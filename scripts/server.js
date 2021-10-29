const { ethers } = require('ethers');
const Koa = require('koa');
const app = new Koa();
require('dotenv').config();

const rpcUrl = 'https://api.avax-test.network/ext/bc/C/rpc';
const fujiProvider = new ethers.providers.StaticJsonRpcProvider(rpcUrl);

// default install on Fuji Avalanche
const smartlockAddress = '0x787250e9C9440DC4056124a2E5A354C02eF3045E';
const smartlockAbi = ['function rentBy() external view returns (address)'];

const port = process.env.PORT || 3000;
const address = process.env.ADDRESS || smartlockAddress;

app.use(async (ctx) => {
  const smartlock = new ethers.Contract(
    address,
    smartlockAbi,
    fujiProvider
  );

  ctx.body = await smartlock.rentBy();
});

app.listen(port);
