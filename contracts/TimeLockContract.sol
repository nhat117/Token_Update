pragma solidity ^0.5.16;

import "./SafeMath.sol";
import "./DLC.sol";
contract TimeLockContract {
    using SafeMath for uint256;

    //Timeline
    uint constant DAY = 86400;
    uint constant WEEK = 604800;
    uint constant MONTH = 2629743;
    uint constant YEAR = 31556926;
    


     struct LockItem {
        uint256  releaseDate;
        uint256  amount;
    }

    address private  owner;  
    address private dlc;


    //Utility variables for transfer and lock
    
    mapping (address => LockItem[]) private lockList;
    address[] private lockedAddressList; // list of addresses that have some fund currently or previously locked

    //Date map
    uint[] private timeLine;
    address private publicSaleWallet =  0x6ecaCced313Bc500aBE6E1ec34BE23888a8E777A;

    constructor(address _dlc) public payable {
        dlc = _dlc;
        owner = msg.sender;
        //Time line for release token
        /**
         * @dev transfer amount according to the frequency period of a time unit
         * @var period total period repeat overtime
         * @var unit hour, month, year - could use these base constant unit declare at constant list to generate custom unit such as quarter, bi-annual,etc
         * @var percentage sent certain % fund each time
         * Total time period = period * unit
         */

        uint8 period = 20;
        uint unit =  3* MONTH;
        uint8 percentage = 5;

        uint256 amount = IBEP20(dlc).balanceOf(msg.sender); 
        for(uint i = 0; i < period; i ++) {
            timeLine.push(block.timestamp + i * unit);
        }
        
        //Start publicSale
        for(uint i = 0; i < timeLine.length; i ++) {
            uint256 transferAmount = amount * uint256(percentage) /100;
            amount.sub(transferAmount);
            transferAndLock(publicSaleWallet, transferAmount,  timeLine[i]);
        }
    }

     /**
     * @dev transfer of token on behalf of the owner to another address. 
     * always require the owner has enough balance and the sender is allowed to transfer the given amount
     * @return the bool true if success. 
     * @param _receiver The address to transfer to.
     * @param _amount The amount to be transferred.
     */

    function transferAndLock(address _receiver, uint256 _amount, uint256 _releaseDate) internal returns (bool success) {
        require(msg.sender == owner);
        IBEP20(dlc).transferFrom(msg.sender,_receiver,_amount);
        if (lockList[_receiver].length==0) lockedAddressList.push(_receiver);
        LockItem memory item = LockItem({amount:_amount, releaseDate:_releaseDate});
        lockList[_receiver].push(item);
        return true;
    }
}