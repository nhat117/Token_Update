// pragma solidity ^0.5.16;

// import "DLC.sol";
// import "SafeMath.sol";

// contract TimeLockContract {
//     using SafeMath for uint256;
//        mapping(address => uint256) private privateSale;
//        mapping (address => LockItem[]) private lockList;
//        address[] private lockedAddressList; // list of addresses that have some fund currently or previously locked
     
    

//      //Date map
//     uint[] private quarterPublic;
//     address private publicSaleWallet =  0x6ecaCced313Bc500aBE6E1ec34BE23888a8E777A;

//       /**
//      * @dev ultils for Transfer and Lock
//      */
    
//     struct LockItem {
//         uint256  releaseDate;
//         uint256  amount;
//     }
    

//     constructor() public payable {
//         //Timeline for Public allocation

//         /**
//          * @dev transfer amount according to the frequency period of a time unit
//          * @var period total period repeat overtime
//          * @var unit hour, month, year - could use these base constant unit declare at constant list to generate custom unit such as quarter, bi-annual,etc
//          * @var percentage sent certain % fund each time
//          * Total time period = period * unit
//          */

//         period = 20;
//         unit =  3* MONTH;
//         uint8 percentage = 5;
//         amount = BEP20Token.balanceOf(msg.sender); //Equivalance of 1 710 000 000 DLC
//         for(uint i = 0; i < period; i ++) {
//             quarterPublic.push(block.timestamp + i * unit);
//         }
//         //Start publicSale
    
//         for(uint i = 0; i < quarterPublic.length; i ++) {
//             uint256 transferAmount = amount * uint256(percentage) /100;
//             amount.sub(transferAmount);
//             transferAndLock(publicSaleWallet, transferAmount,   quarterPublic[i]);
//         }
//     }

    
//      /**
//      * @dev transfer of token on behalf of the owner to another address. 
//      * always require the owner has enough balance and the sender is allowed to transfer the given amount
//      * @return the bool true if success. 
//      * @param _receiver The address to transfer to.
//      * @param _amount The amount to be transferred.
//      */

//     function transferAndLock(address _receiver, uint256 _amount, uint256 _releaseDate) public returns (bool success) {
//         //Require the transferAndLock for only few wallet address
//         require(msg.sender == teamWallet || msg.sender == privateSaleWallet || msg.sender ==   marketingWallet || msg.sender == owner() || msg.sender == partnerWallet);
//         DLCToken._transfer(msg.sender,_receiver,_amount);
        
//         if (lockList[_receiver].length==0) lockedAddressList.push(_receiver);
        
//         LockItem memory item = LockItem({amount:_amount, releaseDate:_releaseDate});
//         lockList[_receiver].push(item);
    
//         return true;
//     }
// }