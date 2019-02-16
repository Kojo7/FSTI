const IPFS = require('ipfs-api');
const ipfs = new IPFS ({host: 'ipfs.infura.io', port: 5001, protocol: 'https'});
 var fs = require('fs');
var Filesaver = require('filesaver');


var printer = require ("node-printer-lp-complete");
var api = require('etherscan-api').init('XYR5XKDIBZDC957BHCYCUDKME1UZNY9A3Q');

//Getting the HASH from Ethereum Transaction
//-----------------------------------------------------------////
function hex2a(hexx) {
    var hex = hexx.toString();//force conversion
    var str = '';
    for (var i = 0; (i < hex.length && hex.substr(i, 2) !== '00'); i += 2)
        str += String.fromCharCode(parseInt(hex.substr(i, 2), 16));
    return str;
};

async function getIpfsData (hash) {
   console.log(hash);
    var x = await ipfs.cat("/ipfs/"+hash);
	  return x;
};

var txlist = api.account.txlist('0xC14c05fE25880e86b8ebac6896557e9823EC2B17', 1, 'latest', 1, 100, 'asc');
txlist.then(async function(txData){
  var res = txData.result[1].input;
  var out = res.split("x");
  var hash = out[1];


var IPFShash = hex2a(hash)

var options = {
    media: 'Custom.200x600mm', // Custom paper size
    destination: "Canon-MG3600-series-2", // The printer name
    n: 1 // Number of copies
};

//var text = "print text directly, when needed: e.g. barcode printers";
var y = await getIpfsData(IPFShash);

const content = y;

fs.writeFile('/home/fsti/Documents/test/t.json', content, 'utf8', function (err) {
    if (err) {
        return console.log(err);
    }

    console.log("The file was saved!");
});

//FileSaver.saveAs(y, "html.txt");
var file = "t.json"
//var jobText = priner.printText(text, options, "text_demo");
var jobFile = printer.printFile(file, options,"file_demo");

var onJobEnd = function () {
    console.log(this.identifier + ", job send to printer queue");
};

var onJobError = function (message) {
    console.log(this.identifier + ", error: " + message);
};

//jobText.on("end", onJobEnd);
//jobText.on("error", onJobError);

jobFile.on("end", onJobEnd);
jobFile.on("error", onJobError);

});
