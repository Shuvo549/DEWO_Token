/*
* 
* $DEWO Token - The Native Token To DecentraWorld's Ecosystem
* DecentraWorld - Increasing Privacy Standards In DeFi
* Built With Zero-Knowledge Privacy Protocols 
*
* Documentation: http://docs.decentraworld.co/
* GitHub: https://github.com/decentraworldDEWO
* Main Website: https://DecentraWorld.co/
* DAO: https://dao.decentraworld.co/
* Governance: https://gov.decentraworld.co/
* DecentraMix: https://decentramix.io/
*
*░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
*░░██████╗░███████╗░█████╗░███████╗███╗░░██╗████████╗██████╗░░█████╗░░░
*░░██╔══██╗██╔════╝██╔══██╗██╔════╝████╗░██║╚══██╔══╝██╔══██╗██╔══██╗░░
*░░██║░░██║█████╗░░██║░░╚═╝█████╗░░██╔██╗██║░░░██║░░░██████╔╝███████║░░
*░░██║░░██║██╔══╝░░██║░░██╗██╔══╝░░██║╚████║░░░██║░░░██╔══██╗██╔══██║░░
*░░██████╔╝███████╗╚█████╔╝███████╗██║░╚███║░░░██║░░░██║░░██║██║░░██║░░
*░░╚═════╝░╚══════╝░╚════╝░╚══════╝╚═╝░░╚══╝░░░╚═╝░░░╚═╝░░╚═╝╚═╝░░╚═╝░░
*░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
*░░░░░░░░░░░░░░██╗░░░░░░░██╗░█████╗░██████╗░██╗░░░░░██████╗░░░░░░░░░░░░
*░░░░░░░░░░░░░░██║░░██╗░░██║██╔══██╗██╔══██╗██║░░░░░██╔══██╗░░░░░░░░░░░
*░░░░░░░░░░░░░░╚██╗████╗██╔╝██║░░██║██████╔╝██║░░░░░██║░░██║░░░░░░░░░░░
*░░░░░░░░░░░░░░░████╔═████║░██║░░██║██╔══██╗██║░░░░░██║░░██║░░░░░░░░░░░
*░░░░░░░░░░░░░░░╚██╔╝░╚██╔╝░╚█████╔╝██║░░██║███████╗██████╔╝░░░░░░░░░░░
*░░░░░░░░░░░░░░░░╚═╝░░░╚═╝░░░╚════╝░╚═╝░░╚═╝╚══════╝╚═════╝░░░░░░░░░░░░
*░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
*
*/
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;
pragma experimental ABIEncoderV2;

import "@OpenZeppelin/contracts/utils/math/SafeMath.sol";
import "@OpenZeppelin/contracts/access/Ownable.sol";
import "@OpenZeppelin/contracts/utils/Context.sol"; 
 

/**
 * @dev Interfaces 
 */

interface IDEXFactory {
    event PairCreated(address indexed token0, address indexed token1, address pair, uint);

    function feeTo() external view returns (address);
    function feeToSetter() external view returns (address);

    function getPair(address tokenA, address tokenB) external view returns (address pair);
    function allPairs(uint) external view returns (address pair);
    function allPairsLength() external view returns (uint);

    function createPair(address tokenA, address tokenB) external returns (address pair);

    function setFeeTo(address) external;
    function setFeeToSetter(address) external;
}

interface IDEXRouter {
    function factory() external pure returns (address);
    function WETH() external pure returns (address);

    function addLiquidity(
        address tokenA,
        address tokenB,
        uint amountADesired,
        uint amountBDesired,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) external returns (uint amountA, uint amountB, uint liquidity);

    function addLiquidityETH(
        address token,
        uint amountTokenDesired,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external payable returns (uint amountToken, uint amountETH, uint liquidity);

    function swapExactTokensForTokensSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;

    function swapExactTokensForETHSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;
}

interface IPancakeswapV2Pair {
    event Approval(address indexed owner, address indexed spender, uint value);
    event Transfer(address indexed from, address indexed to, uint value);

    function name() external pure returns (string memory);
    function symbol() external pure returns (string memory);
    function decimals() external pure returns (uint8);
    function totalSupply() external view returns (uint);
    function balanceOf(address owner) external view returns (uint);
    function allowance(address owner, address spender) external view returns (uint);

    function approve(address spender, uint value) external returns (bool);
    function transfer(address to, uint value) external returns (bool);
    function transferFrom(address from, address to, uint value) external returns (bool);

    function DOMAIN_SEPARATOR() external view returns (bytes32);
    function PERMIT_TYPEHASH() external pure returns (bytes32);
    function nonces(address owner) external view returns (uint);

    function permit(address owner, address spender, uint value, uint deadline, uint8 v, bytes32 r, bytes32 s) external;

    event Mint(address indexed sender, uint amount0, uint amount1);
    event Burn(address indexed sender, uint amount0, uint amount1, address indexed to);
    event Swap(
        address indexed sender,
        uint amount0In,
        uint amount1In,
        uint amount0Out,
        uint amount1Out,
        address indexed to
    );
    event Sync(uint112 reserve0, uint112 reserve1);

    function MINIMUM_LIQUIDITY() external pure returns (uint);
    function factory() external view returns (address);
    function token0() external view returns (address);
    function token1() external view returns (address);
    function getReserves() external view returns (uint112 reserve0, uint112 reserve1, uint32 blockTimestampLast);
    function price0CumulativeLast() external view returns (uint);
    function price1CumulativeLast() external view returns (uint);
    function kLast() external view returns (uint);

    function mint(address to) external returns (uint liquidity);
    function burn(address to) external returns (uint amount0, uint amount1);
    function swap(uint amount0Out, uint amount1Out, address to, bytes calldata data) external;
    function skim(address to) external;
    function sync() external;

    function initialize(address, address) external;
}

/**
 * @dev Interface of the ERC20 standard as defined in the EIP.
 */
interface IERC20 {
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address to, uint256 amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);

    /**
     * @dev Returns the decimals places of the token.
     */
    function decimals() external view returns (uint8);

    /**
     * @dev Moves `amount` tokens from `from` to `to` using the
     * allowance mechanism. `amount` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) external returns (bool);

    /**
     * @dev Emitted when `value` tokens are moved from one account (`from`) to
     * another (`to`).
     *
     * Note that `value` may be zero.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev Emitted when the allowance of a `spender` for an `owner` is set by
     * a call to {approve}. `value` is the new allowance.
     */
    event Approval(address indexed owner, address indexed spender, uint256 value);
}

/**
 * @dev Interface for the optional metadata functions from the ERC20 standard.
 *
 * _Available since v4.1._
 */
interface IERC20Metadata is IERC20 {
    /**
     * @dev Returns the name of the token.
     */
    function name() external view returns (string memory);

    /**
     * @dev Returns the symbol of the token.
     */
    function symbol() external view returns (string memory);
}


contract DecentraWorld is Context, IERC20, IERC20Metadata, Ownable {
    using SafeMath for uint256;
    // DecentraWorld - $DEWO
    uint256 _totalSupply;
    string private _name;
    string private _symbol;
    uint8 private _decimals;
    // Mapping
    mapping(address => uint256) private _balances;
    mapping(address => mapping(address => uint256)) private _allowances;
    mapping (string => uint) taxFees;
    mapping (address => bool) public excludeFromFees;
    mapping (address => bool) public excludeFromMaxTx;
    address public daoandfarmingAddress;
    address public marketingAddress;
    address public developmentAddress;
    address public coreteamAddress;

    struct DEWOTransactionFee {
        uint forMarketing;
        uint forDAOnFarming;
        uint forDevelopment;
        uint forCoreTeam;
    }

    struct MaxTx {
        uint buyLimit;
        uint sellLimit;
        uint cooldown;
        mapping(address => uint) buys;
        mapping(address => uint) sells;
        mapping(address => uint) lastTx;
    }

    // Discounted Buy Tax For Holding x $DEWO
    struct BuyTaxTiers {
        uint buyTaxDiscount;
        uint amount;
    }
    // Discounted Sell Tax For Holding x $DEWO
    struct SellTaxTiers {
        uint sellTaxDiscount;
        uint amount;
    }
    mapping (uint => SellTaxTiers) selltaxTiers;
    mapping (uint => BuyTaxTiers) buytaxTiers;
    MaxTx maxTx;

    IDEXRouter public router;
    address public pair;

    constructor() {
        _name = "DecentraWorld";
        _symbol = "$DEWO";
        _decimals = 18;
        _totalSupply = 100000000 * (10 ** decimals());
        daoandfarmingAddress = msg.sender;
        marketingAddress = msg.sender;
        developmentAddress = msg.sender;
        coreteamAddress = msg.sender;
        // Exclude from MaxTx & Fees by default
        excludeFromFees[msg.sender] = true;
        excludeFromMaxTx[msg.sender] = true;
        excludeFromFees[daoandfarmingAddress] = true;
        excludeFromMaxTx[daoandfarmingAddress] = true;
        excludeFromFees[marketingAddress] = true;
        excludeFromMaxTx[marketingAddress] = true;
        excludeFromFees[developmentAddress] = true;
        excludeFromMaxTx[developmentAddress] = true;
        excludeFromFees[coreteamAddress] = true;
        excludeFromMaxTx[coreteamAddress] = true;
        // Transaction fees apply solely on swaps (buys/sells)
        // Tier 1 - Default Buy Fee [6% Total]
        // Tier 2 - Buy Fee [3% Total]
        // Tier 3 - Buy Fee [0% Total]
        //
        // Automatically set the default transactions fees
        // [Tier 1: 6% Buy Fee]
        taxFees["daonfarminBuy"] = 3;  // [3%] DAO, Governance, Farming Pools
        taxFees["marketingBuy"] = 1;   // [1%] Marketing Fee
        taxFees["developmentBuy"] = 1; // [1%] Development Fee
        taxFees["coreteamBuy"] = 1;    // [1%] DecentraWorld's Core-Team
        // [Tier 1: 10% Sell Fee]
        taxFees["daonfarminSell"] = 4; // 4% DAO, Governance, Farming Pools 
        taxFees["marketingSell"] = 3;  // 3% Marketing Fee
        taxFees["developmentSell"] = 1; // 1% Development Fee
        taxFees["coreteamSell"] = 2; // 2% DecentraWorld's Core-Team
        // Buy/Sell Limits
        maxTx.cooldown = 30 minutes;
        maxTx.buyLimit = _totalSupply.div(80); // 1,25%
        maxTx.sellLimit = _totalSupply.div(800); // 0.25%
        
        // Set all discount tiers to 0/(maxsupply) until $DEWO gets a value
        // Once $DEWO has a LP the 'setDefaultBuySellTaxTiers' function will be executed
        /*
           $DEWO holders can adjust these fees via the DAO dashboard
           Transaction Fees - 3 tiers:
           Buy/Sell: 6%/10% ($0+ balance)
           Supporter: 3%/8%  ($5K+ balance)
           Whales: 0%/6%  ($20K+ balance) 

           Tax Re-distribution Buys (6%/3%/0%):
           DAO Fund/Farming:      3% | 1% | 0%
           Marketing Budget:      1% | 1% | 0% 
           Development Fund:      1% | 0% | 0%
           Core-Team:             1% | 1% | 0% 

           Tax Re-distribution Sells (10%/8%/6%):
           DAO Fund/Farming:        4% | 3% | 3%
           Marketing Budget:        3% | 2% | 1% 
           Development Fund:        1% | 1% | 1%
           Core-Team:               2% | 2% | 1% 
           The community can disable the holder rewards fee and migrate that 
           fee to the rewards/staking pool. This can be done via the Governance portal.
        */
        buytaxTiers[0].buyTaxDiscount = 50;
        buytaxTiers[0].amount = 250000 * (10 ** decimals());  //purchase more than 0.15% at the time for this discount ot apply (tax 3%)
        buytaxTiers[1].buyTaxDiscount = 100;
        buytaxTiers[1].amount = 300000 * (10 ** decimals());   //purchase more than 0.3% at the time for this discount ot apply (tax 0%)
       
        selltaxTiers[0].sellTaxDiscount = 20;
        selltaxTiers[0].amount = 250000 * (10 ** decimals()); //hold more than 0.15% at the time of selling for this discount ot apply (8% sell tax)
        selltaxTiers[1].sellTaxDiscount = 40;
        selltaxTiers[1].amount = 300000 * (10 ** decimals()); //hold more than 0.3% at the time of selling for this discount ot apply (6% sell tax)
 

        // Create a PancakeSwap (DEX) Pair For $DEWO
        address WBNB = 0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c; // Wrapped BNB on Binance Smart Chain
        // BSC mainnet WBNB = 0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c
        address _router = 0x10ED43C718714eb63d5aA57B78B54704E256024E; // PancakeSwap Router (ChainID: 56 = BSC)
        // Mainnet BSC Router: 0x10ED43C718714eb63d5aA57B78B54704E256024E
        router = IDEXRouter(_router);
        pair = IDEXFactory(router.factory()).createPair(WBNB, address(this));
        _allowances[address(this)][address(router)] = _totalSupply;
        approve(_router, _totalSupply);
        _balances[msg.sender] = _totalSupply;
        emit Transfer(address(0), msg.sender, _totalSupply);
    }





    function setdaoandfarmingAddress(address _daoandfarmingAddress) external onlyOwner {
        daoandfarmingAddress = _daoandfarmingAddress;
    }

    function setmarketingAddress(address _marketingAddress) external onlyOwner {
        marketingAddress = _marketingAddress;
    }

    function setdevelopmentAddress(address _developmentAddress) external onlyOwner {
        developmentAddress = _developmentAddress;
    }

    function setcoreteamAddress(address _coreteamAddress) external onlyOwner {
        coreteamAddress = _coreteamAddress;
    }
    
    function setexcludeFromFees(address _address, bool _value) external onlyOwner {
        excludeFromFees[_address] = _value;
    }

    function setexcludeFromMaxTx(address _address, bool _value) external onlyOwner {
        excludeFromMaxTx[_address] = _value;
    }

    // $DEWO Price In BNB
    function getDEWOPriceInBNB(uint _amount) public view returns(uint) {
        IPancakeswapV2Pair pcsPair = IPancakeswapV2Pair(pair);
        IERC20 token1 = IERC20(pcsPair.token1());
        (uint Res0, uint Res1,) = pcsPair.getReserves();
        uint res0 = Res0*(10**token1.decimals());
        return((_amount.mul(res0)).div(Res1)); 
    }
 
    // Set Buy Fees
    event BuyFees(
        uint _marketingBuy,
        uint _developmentBuy,
        uint _daonfarmingBuy,
        uint _coreteamBuy
    );
    function setBuyFees(
        uint _marketingBuy,
        uint _developmentBuy,
        uint _daonfarmingBuy,
        uint _coreteamBuy
    ) external onlyOwner {
        require(_marketingBuy <= 6, "Marketing fee is too high!");
        taxFees["marketingBuy"] = _marketingBuy;
        require(_daonfarmingBuy <= 6, "Liquidity fee is too high!");
        taxFees["daonfarminBuy"] = _daonfarmingBuy;
        require(_developmentBuy <= 6, "Dev fee is too high!");
        taxFees["developmentBuy"] = _developmentBuy;
        require(_coreteamBuy <= 6, "Farming fee is too high!");
        taxFees["coreteamBuy"] = _coreteamBuy;
        emit BuyFees(
            _daonfarmingBuy,
            _marketingBuy,
            _developmentBuy, 
            _coreteamBuy
        );
    }
    
    // Set Sell Fees
    event SellFees(
        uint _marketingSell,
        uint _developmentSell,
        uint _daonfarmingSell,
        uint _coreteamSell
    );
    function setSellFees(
        uint _marketingSell,
        uint _developmentSell,
        uint _daonfarmingSell,
        uint _coreteamSell
    ) external onlyOwner {
        require(_marketingSell <= 6, "Marketing fee is too high!");
        taxFees["marketingSell"] = _marketingSell;
        require(_daonfarmingSell <= 6, "Liquidity fee is too high!");
        taxFees["daonfarminSell"] = _daonfarmingSell;
        require(_coreteamSell <= 6, "Farming fee is too high!");
        taxFees["coreteamSell"] = _coreteamSell;
        require(_developmentSell <= 6, "Dev fee is too high!");
        taxFees["developmentSell"] = _developmentSell;
        emit SellFees(
            _daonfarmingSell,
            _marketingSell,
            _developmentSell,
            _coreteamSell
        );
    }

    function getBuyFees() public view returns(
        uint marketingBuy,
        uint developmentBuy,
        uint daonfarminBuy,
        uint coreteamBuy
    ) {
        return (
            taxFees["daonfarminBuy"],
            taxFees["marketingBuy"],
            taxFees["developmentBuy"],
            taxFees["coreteamBuy"]
        );
    }

        function getSellFees() public view returns(
        uint marketingSell,
        uint developmentSell,
        uint daonfarminSell,
        uint coreteamSell
    ) {
        return (
            taxFees["daonfarminSell"],
            taxFees["marketingSell"],
            taxFees["developmentSell"],
            taxFees["coreteamSell"]
        );
    }
 
 
    // Set Buy Tax Discounted Tiers For Tier 2 & 3 Wallet - in DEWO tokens 
    function setBuyTaxTiersTokens(uint _discount1, uint _amount1, uint _discount2, uint _amount2) external onlyOwner {
        require(_discount1 > 0 && _discount2 > 0 && _amount1 > 0 && _amount2 > 0, "Values have to be bigger than zero!");
        buytaxTiers[0].buyTaxDiscount = _discount1; //default: 50
        buytaxTiers[0].amount = _amount1;  //default: 5,000 BUSD worth of $DEWO
        buytaxTiers[1].buyTaxDiscount = _discount2; //default: 100
        buytaxTiers[1].amount = _amount2;  //default: 20,000 BUSD worth of $DEWO
    }

    // Set Sell Tax Discounted Tiers For Tier 2 & 3 Wallet - in DEWO tokens 
    function setSellTaxTiersTokens(uint _discount1, uint _amount1, uint _discount2, uint _amount2) external onlyOwner {
        require(_discount1 > 0 && _discount2 > 0 && _amount1 > 0 && _amount2 > 0, "Values have to be bigger than zero!");
        selltaxTiers[0].sellTaxDiscount = _discount1; //default: 20
        selltaxTiers[0].amount = _amount1;  //default: 5,000 BUSD worth of $DEWO
        selltaxTiers[1].sellTaxDiscount = _discount2; //default: 40
        selltaxTiers[1].amount = _amount2;  //default: 20,000 BUSD worth of $DEWO
    }


    // Return The Difference Back To The Transaction
    function getbuytaxTiers() public view returns(uint discount1, uint amount1, uint discount2, uint amount2) {
        return (buytaxTiers[0].buyTaxDiscount, buytaxTiers[0].amount, buytaxTiers[1].buyTaxDiscount, buytaxTiers[1].amount);
    }

     // Return The Difference Back To The Transaction
    function getselltaxTiers() public view returns(uint discount1, uint amount1, uint discount2, uint amount2) {
        return (selltaxTiers[0].sellTaxDiscount, selltaxTiers[0].amount, selltaxTiers[1].sellTaxDiscount, selltaxTiers[1].amount);
    }

    // Set Max Transaction But Limit / Sell Limit  Cooldown
    function setmaxTx(uint _buyLimit, uint _sellLimit, uint _cooldown) external onlyOwner {
        require(_buyLimit >= _totalSupply.div(200), "DecentraWorld: buy transactions must be above 0.5% of the total supply"); // 0.5%
        require(_sellLimit >= _totalSupply.div(500), "DecentraWorld: sell transactions must be above 0.2% of the total supply"); // 0.2%
        require(_cooldown <= 300 minutes, "DecentraWorld: Cooldown must be less than 5 hours.");
        maxTx.buyLimit = _buyLimit;
        maxTx.sellLimit = _sellLimit;
        maxTx.cooldown = _cooldown;
    }

    function getmaxTx() public view returns(uint buyLimit, uint sellLimit, uint cooldown) {
        return (maxTx.buyLimit, maxTx.sellLimit, maxTx.cooldown);
    }

    // Check Buy MaxTx Amount
    function checkBuyMaxTx(address _sender, uint256 _amount) internal view {
        require(
            excludeFromMaxTx[_sender] == true ||
            maxTx.buys[_sender].add(_amount) < maxTx.buyLimit,
            "Buy transaction limit reached!"
        );
    }

    // Check Sell MaxTx Amount
    function checkSellMaxTx(address _sender, uint256 _amount) internal view {
        require(
            excludeFromMaxTx[_sender] == true ||
            maxTx.sells[_sender].add(_amount) < maxTx.sellLimit,
            "Sell transaction limit reached!"
        );
    }
    
    // Save Recent Transaction Buy/Sell While Cooldown Is Active
    function setRecentTx(bool _isSell, address _sender, uint _amount) internal {
        if(maxTx.lastTx[_sender].add(maxTx.cooldown) < block.timestamp) {
            _isSell ? maxTx.sells[_sender] = _amount : maxTx.buys[_sender] = _amount;
        } else {
            _isSell ? maxTx.sells[_sender] += _amount : maxTx.buys[_sender] += _amount;
        }

        maxTx.lastTx[_sender] = block.timestamp;
    }

    function getRecentTx(address _address) public view returns(uint buys, uint sells, uint lastTx) {
        return (maxTx.buys[_address], maxTx.sells[_address], maxTx.lastTx[_address]);
    }


    /**
     * @dev Returns the name of the token.
     */
    function name() public view virtual override returns (string memory) {
        return _name;
    }

    /**
     * @dev Returns the symbol of the token, usually a shorter version of the
     * name.
     */
    function symbol() public view virtual override returns (string memory) {
        return _symbol;
    }

    function decimals() public view virtual override returns (uint8) {
        return _decimals;
    }
    
    function totalSupply() public view virtual override returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address account) public view virtual override returns (uint256) {
        return _balances[account];
    }

    /**
     * @dev See {IERC20-transfer}.
     *
     * Requirements:
     *
     * - `to` cannot be the zero address.
     * - the caller must have a balance of at least `amount`.
     */
    function transfer(address to, uint256 amount) public virtual override returns (bool) {
        address owner = _msgSender();
        _transfer(owner, to, amount);
        return true;
    }

    /**
     * @dev See {IERC20-allowance}.
     */
    function allowance(address owner, address spender) public view virtual override returns (uint256) {
        return _allowances[owner][spender];
    }

    /**
     * @dev See {IERC20-approve}.
     *
     * NOTE: If `amount` is the maximum `uint256`, the allowance is not updated on
     * `transferFrom`. This is semantically equivalent to an infinite approval.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     */
    function approve(address spender, uint256 amount) public virtual override returns (bool) {
        address owner = _msgSender();
        _approve(owner, spender, amount);
        return true;
    }

    /**
     * @dev See {IERC20-transferFrom}.
     *
     * Emits an {Approval} event indicating the updated allowance. This is not
     * required by the EIP. See the note at the beginning of {ERC20}.
     *
     * NOTE: Does not update the allowance if the current allowance
     * is the maximum `uint256`.
     *
     * Requirements:
     *
     * - `from` and `to` cannot be the zero address.
     * - `from` must have a balance of at least `amount`.
     * - the caller must have allowance for ``from``'s tokens of at least
     * `amount`.
     */
    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) public virtual override returns (bool) {
        address spender = _msgSender();
        _spendAllowance(from, spender, amount);
        _transfer(from, to, amount);
        return true;
    }

    /**
     * @dev Atomically increases the allowance granted to `spender` by the caller.
     *
     * This is an alternative to {approve} that can be used as a mitigation for
     * problems described in {IERC20-approve}.
     *
     * Emits an {Approval} event indicating the updated allowance.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     */
    function increaseAllowance(address spender, uint256 addedValue) public virtual returns (bool) {
        address owner = _msgSender();
        _approve(owner, spender, allowance(owner, spender) + addedValue);
        return true;
    }

    /**
     * @dev Atomically decreases the allowance granted to `spender` by the caller.
     *
     * This is an alternative to {approve} that can be used as a mitigation for
     * problems described in {IERC20-approve}.
     *
     * Emits an {Approval} event indicating the updated allowance.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     * - `spender` must have allowance for the caller of at least
     * `subtractedValue`.
     */
    function decreaseAllowance(address spender, uint256 subtractedValue) public virtual returns (bool) {
        address owner = _msgSender();
        uint256 currentAllowance = allowance(owner, spender);
        require(currentAllowance >= subtractedValue, "ERC20: decreased allowance below zero");
        unchecked {
            _approve(owner, spender, currentAllowance - subtractedValue);
        }

        return true;
    }

    /**
     * @dev Moves `amount` of tokens from `sender` to `recipient`.
     *
     * This internal function is equivalent to {transfer}, and can be used to
     * e.g. implement automatic token fees, slashing mechanisms, etc.
     *
     * Emits a {Transfer} event.
     *
     * Requirements:
     *
     * - `from` cannot be the zero address.
     * - `to` cannot be the zero address.
     * - `from` must have a balance of at least `amount`.
     */
    function _transfer(
        address from,
        address to,
        uint256 amount
    ) internal virtual {
        require(from != address(0), "ERC20: transfer from the zero address");
        require(to != address(0), "ERC20: transfer to the zero address");

        uint256 fromBalance = _balances[from];
        require(fromBalance >= amount, "ERC20: transfer amount exceeds balance");

        uint marketingFee;
        uint developmentFee;
        uint daonfarmingFee;
        uint coreteamFee;
        uint buyTaxDiscount;
        uint sellTaxDiscount;
        bool hasFees = true;

        // BUY
        if(from == pair) {
            checkBuyMaxTx(to, amount);  

            setRecentTx(false, to, amount);

            marketingFee = taxFees["marketingBuy"];
            developmentFee = taxFees["developmentBuy"];
            daonfarmingFee = taxFees["daonfarminBuy"];
            coreteamFee = taxFees["coreteamBuy"];

            // Buy Tax Discounts For Tier 2 & 3 Holders
            if(amount >= buytaxTiers[0].amount && amount < buytaxTiers[1].amount) {
                buyTaxDiscount = buytaxTiers[0].buyTaxDiscount;
            } else if(amount >= buytaxTiers[1].amount) {
                buyTaxDiscount = buytaxTiers[1].buyTaxDiscount;
            }
        }
        // SELL
        else if(to == pair) {
            checkSellMaxTx(from, amount);
            setRecentTx(true, from, amount);

            marketingFee = taxFees["marketingSell"];
            developmentFee = taxFees["developmentSell"];
            daonfarmingFee = taxFees["daonfarminSell"];
            coreteamFee = taxFees["coreteamSell"];

            // Sell Tax Discounts For Tier 2 & 3 Holders
            if(fromBalance >= selltaxTiers[0].amount && fromBalance < selltaxTiers[1].amount) {
                sellTaxDiscount = selltaxTiers[0].sellTaxDiscount;
            } else if(fromBalance >= selltaxTiers[1].amount) {
                sellTaxDiscount = selltaxTiers[1].sellTaxDiscount;
            }
        }

        unchecked {
            _balances[from] = fromBalance - amount;
        }

        if(excludeFromFees[to] || excludeFromFees[from]) {
            hasFees = false;
        }

        if(hasFees && (to == pair)) {
            DEWOTransactionFee memory DEWOTransactionFees;
            DEWOTransactionFees.forDAOnFarming = amount.mul(daonfarmingFee).mul(100 - sellTaxDiscount).div(10000);
            DEWOTransactionFees.forMarketing = amount.mul(marketingFee).mul(100 - sellTaxDiscount).div(10000);
            DEWOTransactionFees.forDevelopment = amount.mul(developmentFee).mul(100 - sellTaxDiscount).div(10000);
            DEWOTransactionFees.forCoreTeam = amount.mul(coreteamFee).mul(100 - sellTaxDiscount).div(10000);

            _balances[daoandfarmingAddress] += DEWOTransactionFees.forDAOnFarming; // DAO Fund / Governance / Farming Pools
            emit Transfer(from, daoandfarmingAddress, DEWOTransactionFees.forDAOnFarming);

            _balances[daoandfarmingAddress] += DEWOTransactionFees.forMarketing; // Marketing Fund
            emit Transfer(from, daoandfarmingAddress, DEWOTransactionFees.forMarketing);

            _balances[daoandfarmingAddress] += DEWOTransactionFees.forDevelopment; // Development Fund
            emit Transfer(from, daoandfarmingAddress, DEWOTransactionFees.forDevelopment);

            _balances[daoandfarmingAddress] += DEWOTransactionFees.forCoreTeam; // Core-Team
            emit Transfer(from, daoandfarmingAddress, DEWOTransactionFees.forCoreTeam);
        }

                if(hasFees && (from == pair)) {
            DEWOTransactionFee memory DEWOTransactionFees;
            DEWOTransactionFees.forDAOnFarming = amount.mul(daonfarmingFee).mul(100 - buyTaxDiscount).div(10000);
            DEWOTransactionFees.forMarketing = amount.mul(marketingFee).mul(100 - buyTaxDiscount).div(10000);
            DEWOTransactionFees.forDevelopment = amount.mul(developmentFee).mul(100 - buyTaxDiscount).div(10000);
            DEWOTransactionFees.forCoreTeam = amount.mul(coreteamFee).mul(100 - buyTaxDiscount).div(10000);

            _balances[daoandfarmingAddress] += DEWOTransactionFees.forDAOnFarming; // DAO Fund / Governance / Farming Pools
            emit Transfer(from, daoandfarmingAddress, DEWOTransactionFees.forDAOnFarming);

            _balances[daoandfarmingAddress] += DEWOTransactionFees.forMarketing; // Marketing Fund
            emit Transfer(from, daoandfarmingAddress, DEWOTransactionFees.forMarketing);

            _balances[daoandfarmingAddress] += DEWOTransactionFees.forDevelopment; // Development Fund
            emit Transfer(from, daoandfarmingAddress, DEWOTransactionFees.forDevelopment);

            _balances[daoandfarmingAddress] += DEWOTransactionFees.forCoreTeam; // Core-Team
            emit Transfer(from, daoandfarmingAddress, DEWOTransactionFees.forCoreTeam);
        }
        _balances[to] += amount;
        emit Transfer(from, to, amount);
    }

    /**
     * @dev Sets `amount` as the allowance of `spender` over the `owner` s tokens.
     *
     * This internal function is equivalent to `approve`, and can be used to
     * e.g. set automatic allowances for certain subsystems, etc.
     *
     * Emits an {Approval} event.
     *
     * Requirements:
     *
     * - `owner` cannot be the zero address.
     * - `spender` cannot be the zero address.
     */
    function _approve(
        address owner,
        address spender,
        uint256 amount
    ) internal virtual {
        require(owner != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");

        _allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }

    /**
     * @dev Updates `owner` s allowance for `spender` based on spent `amount`.
     *
     * Does not update the allowance amount in case of infinite allowance.
     * Revert if not enough allowance is available.
     *
     * Might emit an {Approval} event.
     */
    function _spendAllowance(
        address owner,
        address spender,
        uint256 amount
    ) internal virtual {
        uint256 currentAllowance = allowance(owner, spender);
        if (currentAllowance != type(uint256).max) {
            require(currentAllowance >= amount, "ERC20: insufficient allowance");
            unchecked {
                _approve(owner, spender, currentAllowance - amount);
            }
        }
    }
}