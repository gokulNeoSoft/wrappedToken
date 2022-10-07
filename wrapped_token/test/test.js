const WTokenContract = artifacts.require('WrappedToken')
const token = artifacts.require('Gtoken')
const truffleAssert = require('truffle-assertions')

contract('WTokenContract', async (accounts) => {
  var [user1, user2] = accounts
  var _WTokenContract
  var _token1
  var zero_address = '0x0000000000000000000000000000000000000000'

  beforeEach(async () => {
    _token1 = await token.new()
    _WTokenContract = await WTokenContract.new(_token1.address)
  })
  describe('Wrapped Tokens test:', async function () {
    it('Deployment test', async function () {
      assert.equal(await _WTokenContract.tokenAddress(), _token1.address)
    })

    it('Mint test', async function () {
      await truffleAssert.reverts(
        _WTokenContract.mint(10),
        'INSUFFICIENT TOKENS!',
      )
      await _token1.mint(user1, 50)
      await _token1.approve(_WTokenContract.address, '50000000000000000000')
      await _WTokenContract.mint(10)
      assert.equal(await _WTokenContract.balanceOf(user1), 10000000000000000000)
      assert.equal(
        await _token1.balanceOf(await _WTokenContract.address),
        10000000000000000000,
      )
    })

    it('Burn test', async function () {
      await _token1.mint(user1, 50)
      await _token1.approve(_WTokenContract.address, '50000000000000000000')
      await _WTokenContract.mint(10)

      await _WTokenContract.burn(10)
      assert.equal(await _WTokenContract.balanceOf(user1), 0)
      assert.equal(
        await _token1.balanceOf(await _WTokenContract.address),
        0
      )
    })
  })
})
