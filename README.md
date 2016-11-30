*API doc*
**Get Public Key**
----
Get Private line public Key

* **URL**

  /api/v1/keys

* **Method:**

  `GET`
  
* **Success Response:**

  * **Code:** 200 <br />
    **Content:** `{ public_key : "-----BEGIN PUBLIC KEY-----\nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEArhPHlBcTCeVckL4cn/kh\nF6o/Rpik1oA68L2j1zFhxTlkMa0Pr/zl0+V5CqreuJ6RHd4d6kZGUv9pCt4Wz5ZK\nhIIpRjwPM5Sap3eTOMUoOWeZYF5qgZQ/hTkskVoFIv4AAl4Bx1DkdfUY7zcB3Tjt\n1cXzJMdom6AxP/i/t6/wbk2/tQ1iFqLbbpEI+E4d+jxKrvWBg5dAtEmco6IlLUDo\ncAs95A6hEaFGb8X8XV9a6yPlqQnQ/x312oYw7PCiMm+4TjTIogYXJMAhUwUNOjks\n3X4aw6EoyxzKCyi/TRK52Iugq++4rneUOpFtSPs0YeJvY8sda6RGxsmzcytBvc8o\n6wIDAQAB\n-----END PUBLIC KEY-----\n" }`
 
* **Error Response:**

  * **Code:** 400 BAD REQUEST <br />
    **Content:** `{ error : "Bad Request" }`

* **Sample Call:**

```js
 $.ajax({
    url: "/users/1",
    dataType: "json",
    type : "GET",
    success : function(r) {
      console.log(r);
    }
  });
```

* **Notes:**

  <_This is where all uncertainties, commentary, discussion etc. can go. I recommend timestamping and identifying oneself when leaving comments here._> 
