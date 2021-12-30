pragma solidity 0.5.16;
import "./SafeMath.sol";
import "./IBEP20.sol";
import "./BEP20Token.sol";

/**
 * @dev Implementation of DLC TOKEN
 * This contract is base on the Implementation of BEP20Token and 5ROI TOKEN
 * src: https://github.com/binance-chain/BEPs/blob/master/BEP20.md
 * src: https://github.com/5roiglobal/smartcontract
 */
 

contract DLCToken  is BEP20Token{
    using SafeMath for uint256;

    /**
     * @dev total coin supply and decimals
     * @var DLCSUPPLY total DLC coin supply
     * @var DECIMALS Decimals of DLC TOKEN
     */

    uint256 constant DLCSUPPLY = 2500000000;
    uint8 constant DECIMALS = 18;

    /**
     * @dev add address of fund receiver for the initial fund allocation 
    */
    
    address private marketingWallet =   0x4fcD01Edf05b1EBD8f66638f6C9d0312Df8af4ce;
    address private teamWallet =        0xB1C594206145e3401e4005A69114134c2E2a3fB3;
    address private partnerWallet =     0x4E47FCf5908F5f88F33E7b0f558e234ABAA7C246;
    address private publicSaleWallet =  0x6ecaCced313Bc500aBE6E1ec34BE23888a8E777A;
    address private privateSaleWallet = 0xEde137b8baB8f4F15F26233c79b781EF8B11d538;
    
    uint256 amount;

    uint256 amountWithDecimal = 10 ** uint256(DECIMALS);
    constructor() public payable BEP20Token("DLC","DLCTOKEN", DLCSUPPLY, DECIMALS) {
        /**
         * @dev modified the amount that want to transfer 
         * @var amount enter a human friendly amount 
         */

       
        amount = 40000000;
        BEP20Token.transfer(privateSaleWallet, amount * amountWithDecimal);
        
        //Partner allocation
        amount = 250000000;
        BEP20Token.transfer(partnerWallet, amount * amountWithDecimal);
        
        //Team allocation
        amount = 250000000; 
        BEP20Token.transfer(teamWallet, amount * amountWithDecimal);
        
        //Marketing wallet allocation
        amount = 250000000; 
        BEP20Token.transfer(marketingWallet, amount * amountWithDecimal);
    }
    
    /**
     * @dev transfer of token to another address.
     * always require the sender has enough balance
     * @return the bool true if success. 
     * @param _receiver The address to transfer to.
     * @param _amount The amount to be transferred.
     */

    function transfer(address _receiver, uint256 _amount) public whenNotPaused returns (bool success) {
        require(_receiver != address(0)); 
        require(_amount <= getAvailableBalance(msg.sender));
        return BEP20Token.transfer(_receiver, _amount);
    }

    /**
     * @dev transfer of token on behalf of the owner to another address. 
     * always require the owner has enough balance and the sender is allowed to transfer the given amount
     * @return the bool true if success. 
     * @param _from The address to transfer from.
     * @param _receiver The address to transfer to.
     * @param _amount The amount to be transferred.
     */
    
     
    function transferFrom(address _from, address _receiver, uint256 _amount) public whenNotPaused returns (bool) {
        require(_from != address(0));
        require(_receiver != address(0));
        require(_amount <= BEP20Token.allowance(_from, msg.sender));
        require(_amount <= getAvailableBalance(_from));
        return BEP20Token.transferFrom(_from, _receiver, _amount);
    }

    
   /**
     * @dev check of locked funds of a given address.
     * @return the total amount 
     * @param lockedAddress The address to check.
     */
     
    function getAvailableBalance(address lockedAddress) public view returns(uint256 _amount) {
        uint256 bal = BEP20Token.balanceOf(lockedAddress);
        return bal;
    }
    
   /**
     * @dev  check amount circulating coins that are not locked at the current time
     * @return the total amount
     */
     
    function getCirculatingSupplyTotal() public view returns(uint256 _amount) {
        return BEP20Token.totalSupply();
    }
}