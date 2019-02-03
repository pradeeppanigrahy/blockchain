pragma solidity ^0.4.25;

contract Innovation
{
    enum StateType { Submitted, ReviewDone, Approved, Terminated,Rejected }
    address public InstanceInnovator;
    string public Description;
    string public Title;
    string public AdditionalDetails;
   
    StateType public State;

    address public InstanceReviewer;
    address public InstanceApprover;

    constructor(string title, string description,string additionalDetails) public
    {
        InstanceInnovator = msg.sender;
        Title = title;
        Description = description;
        AdditionalDetails = additionalDetails;
        State = StateType.Submitted;
    }

    function Terminate() public
    {
        if (InstanceInnovator != msg.sender)
        {
            revert();
        }

        State = StateType.Terminated;
    }

    function ModifyIdea( string description,string additionalDetails) public
    {
        if (State != StateType.Submitted)
        {
            revert();
        }
        if (InstanceInnovator != msg.sender)
        {
            revert();
        }

        Description = description;
        AdditionalDetails = additionalDetails;
    }

    function ApproveIdea() public
    {
        if (State != StateType.ReviewDone)
        {
            revert("Invalid state for transition");
        }
        if (InstanceInnovator == msg.sender)
        {
            revert("Not enough permission to perform this action");
        }

        State = StateType.Approved;
    }

    function ReviewDone() public
    {
        if (State != StateType.Submitted)
        {
            revert("Invalid state for transition");
        }
        if (InstanceInnovator == msg.sender)
        {
            revert("Not enough permission to perform this action");
        }

        State = StateType.ReviewDone;
    }

    function RejectIdea() public
    {
        if (State != StateType.Submitted && State!=StateType.ReviewDone)
        {
            revert("Not allowed to change state");
        }
        if (InstanceInnovator == msg.sender)
        {
            revert("Not enough permission to perform this action");
        }
        // if (InstanceApprover != msg.sender && InstanceReviewer!=msg.sender)
        // {
        //     revert("Not enough permission to perform this action");
        // }

        InstanceApprover = 0x0;
        InstanceReviewer = 0x0;
        State = StateType.Rejected;
    }

   
   
}