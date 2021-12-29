const DLC = artifacts.require("DLC.sol");

contract('Hello',()=>{
  
  it("should assert true", async()=>{
    const test = await DLC.new();
      await test.address;
      assert(test!= '');
  });

  it("should assert true for totalSupply", async()=>{
    const test = await DLC.new();
    await test.address;
    const data = '2500000000000000000000000000';
    assert(test.getCirculatingSupplyTotal().toString() === data);
  });
});