*API doc*
----
Private Line API documentation


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
  * For debugging purposes, GET /keys is returning also `private_key` and a `encrypted_msg` to play around.
  
**Decrypt Stone**
----
Decrypt Stone to a JSON format

* **URL**

  /api/v1/decrypt

* **Method:**

  `POST`
  
*  **URL Params**

   **Required:**
 
   `stone=[String]`
  
* **Success Response:**

  * **Code:** 200 <br />
    **Content:** `{ stone : {...} }`
 
* **Error Response:**

  * **Code:** 400 BAD REQUEST <br />
    **Content:** `{ error : "unable to decode64"}` <br />
    **Details:** Data param `stone` is not coded in Base64. PrivateLine was not able to decode Base64
    
  * **Code:** 400 BAD REQUEST <br />
    **Content:** `{ error : "No valid JSON format"}` <br />
    **Details:** Data param `stone` is not a valid JSON.
    

* **Sample Call:**

```js
 data = {
     stone: "recmLAWv9BxD7qPHlX6GDUqFYvKnCB31Nne5InprhVyUseb2bCIZL+Zd" +
            "HKm8l2j9EIiJKT9tIMCZU5OmSZ2i9oMZ8QwimAwEGGYG26ftbLdDvFt" +
            "iACetGfvGOxGPRZ2MSFFCmHuM8jZH42R1ho9TVqfzNC+WW7lJVN6D8W" +
            "pIzbIh919pDQRL/NdE9TFMXar59xafkjAlJbXe/K1/rjpxATTwf+guE" +
            "QqmZlErtzw/I9gAKjHxvcF+gf/wEFjSOANAAjBzQDGow42JNtU0wgi6" +
            "L40aguFXhD8QcNART54kHmSoGx7P1POm22dgJ+ZorT4g5s6DhFOUY1u" +
            "BxwN6MCURjg=="
  }

 $.ajax({
    url: "/api/v1/decrypt",
    dataType: "json",
    data: data,
    type : "POST",
    success : function(r) {
      console.log(r);
    }
  });
```

* **Notes:**
:)

**Decrypt and Merge Stone**
----
Decrypt Stone to a JSON format and merge with a Destination Format.

* **URL**

  /api/v1/decrypt_and_merge

* **Method:**

  `POST`
  
*  **URL Params**

   **Required:**
 
   `stone=[String]`<br />
   'destination_format'<br />
   'destination_variables'<br />
  
* **Success Response:**

  * **Code:** 200 <br />
    **Content:** `{ stone : {...}, destination_format: {...}`
 
* **Error Response:**

  * **Code:** 400 BAD REQUEST <br />
    **Content:** `{ error : "unable to decode64"}` <br />
    **Details:** Data param `stone` is not coded in Base64. PrivateLine was not able to decode Base64
    
  * **Code:** 400 BAD REQUEST <br />
    **Content:** `{ error : "No valid JSON format"}` <br />
    **Details:** Data param `stone` is not a valid JSON.
    
  * **Code:** 400 BAD REQUEST <br />
    **Content:** `{ error : "Destination Format, Variables and Stone doesnt match"}` <br />
    **Details:** Data param `stone` doesnt contain key defined in `destination_variables`. Verify `Stone` content and `destination_variables` array.
    

* **Sample Call:**

```js
  data = {
    stone: "recmLAWv9BxD7qPHlX6GDUqFYvKnCB31Nne5InprhVyUseb2bCIZL+Zd" +
           "HKm8l2j9EIiJKT9tIMCZU5OmSZ2i9oMZ8QwimAwEGGYG26ftbLdDvFt" +
           "iACetGfvGOxGPRZ2MSFFCmHuM8jZH42R1ho9TVqfzNC+WW7lJVN6D8W" +
           "pIzbIh919pDQRL/NdE9TFMXar59xafkjAlJbXe/K1/rjpxATTwf+guE" +
           "QqmZlErtzw/I9gAKjHxvcF+gf/wEFjSOANAAjBzQDGow42JNtU0wgi6" +
           "L40aguFXhD8QcNART54kHmSoGx7P1POm22dgJ+ZorT4g5s6DhFOUY1u" +
           "BxwN6MCURjg==",
    destination_format: "<vaulted-shopper xmlns='http://ws.plimus.com'><first-name>" +
                         "{{{billing_first_name}}}</first-name><last-name>{{{billing_last_name}}}</last-name>" +
                         "<payment-sources><credit-card-info><credit-card><card-number>{{{billing_address1}}}</card-number>" +
                         "<security-code>{{{billing_address2}}}</security-code>{{{billing_city}}}" +
                         "<expiration-month>04</expiration-month><expiration-year>2018</expiration-year>" +
                         "</credit-card><billing-contact-info><first-name>Juan Carlos</first-name>" +
                         "<last-name>Lude&#xF1;a</last-name><address1>las palmas</address1><address2/>" +
                         "<city>New York</city><state>Alaska</state><zip>99812</zip><country>PE</country>" +
                         "</billing-contact-info></credit-card-info></payment-sources></vaulted-shopper>",
  destination_variables: ["billing_first_name", "billing_last_name", "billing_address1", "billing_address2", "billing_city"]                       
  }

 $.ajax({
    url: "/api/v1/decrypt_and_merge",
    dataType: "json",
    data : data,
    type : "POST",
    success : function(r) {
      console.log(r);
    }
  });
```

* **Notes:**
:)
