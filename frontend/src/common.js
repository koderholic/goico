import axios from 'axios';

export const HTTP = axios.create({
  baseURL: ``,
  // baseURL: `http://192.168.8.190:4190`,
  headers: {
    Authorization: 'Bearer {token}'
  }
})


export function checkRedirect(respData) {
  if (respData.Body !== null) {
    if (respData.Body.Redirect !== null && respData.Body.Redirect !== undefined && respData.Body.Redirect !== "") {
      window.location.href = '/#'+respData.Body.Redirect
    }
  }
}


export function displayImage(event, app, field ) {
  var reader = new FileReader();
  var selectedFile = event.target.files[0];
  event.target.value = '';
  reader.readAsDataURL(selectedFile);
  reader.onload = function () {
    if (selectedFile.size > 10240000) {
      app.notifications.push({
        Code: 0,
        Message: "Image File must be less than 10MB"
      })
    } else {
      switch (selectedFile.type) {
        case "image/gif":
        case "image/png":
        case "image/jpg":
        case "image/jpeg":
          app.record[field] = reader.result;
          break;

        default:
          app.notifications.push({
            Code: 0,
            Message: "File Must be a valid Image"
          })
          break
      }
    }
  };
  reader.onerror = function (error) {
    app.notifications.push({Code:0,Message:"Image Error:"+error})
  };
}

export function uploadFilePDF(event, app, field) {
  var reader = new FileReader();
  var selectedFile = event.target.files[0];
  event.target.value = '';
  reader.readAsDataURL(selectedFile);
  reader.onload = function () {
    if (selectedFile.size > 10240000) {
      app.notifications.push({
        Code: 0,
        Message: "File must be less than 10MB"
      })
    } else {
      switch (selectedFile.type) {
        case "application/pdf":
          app.record[field] = reader.result;
          app.notifications.push({
            Code: 200,
            Message: "PDF file selected"
          })
          break;

        default:
          app.notifications.push({
            Code: 0,
            Message: "Only PDF Files allowed"
          })
          break
      }
    }
  };
  reader.onerror = function (error) {
    app.notifications.push({
      Code: 0,
      Message: "Image Error:" + error
    })
  };
}
