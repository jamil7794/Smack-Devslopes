import mongodb from 'mongodb';

export default {
   "port": 3005,
   "mongoUrl": "mongodb://localhost:27017/chat-api",
  //"port": process.env.PORT,
  "mongoUrl": "mongodb://jamil77:abc123@ds117101.mlab.com:17101/heroku_tvtl1n5r",
  "bodyLimit": "100kb"
}
