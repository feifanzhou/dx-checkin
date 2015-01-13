function capture(video, canvas, image, captureButton, stopButton, snapshotButton) {
  var ctx = canvas.getContext('2d');
  var localMediaStream = null;

  captureButton.disabled = true;
  snapshotButton.disabled = false;

  window.URL = window.URL || window.webkitURL;
  navigator.getUserMedia  = navigator.getUserMedia || navigator.webkitGetUserMedia ||
              navigator.mozGetUserMedia || navigator.msGetUserMedia;

  var constraints = {
    video: true
  }

  var successCallback = function(mediaStream) {
    video.src = (window.URL && window.URL.createObjectURL(mediaStream)) || mediaStream;
    video.addEventListener("loadedmetadata", function(e) {
      video.style.display = "block";
      localMediaStream = mediaStream;
      snapshotButton.onclick = function(event) {
        video.style.display = "none";
        document.getElementById('clearButtonContainer').style.display = 'block';
        document.getElementById('snapButtonContainer').style.display = 'none';
        document.getElementById('submitButton').removeAttribute('disabled');
        takePhoto();
      }
    });
  };

  var errorCallback = function() {
    console.log("failure to get media");
  };

  var takePhoto = function () {
    ctx.drawImage(video, 0, 0, 480, 360);
    showImage();
  };

  var showImage = function () {
    imgString = canvas.toDataURL('image/jpg');
    image.src = imgString
    image.style.display = "block";
    document.getElementById('kid_image').value = imgString
  };

  var stop = function () {
    if (localMediaStream) {
      localMediaStream.stop(); /* TODO: it doesn't work in Opera Mobile 12 */
    }

    captureButton.disabled = false;
    stopButton.disabled = true;
    snapshotButton.disabled = true;
  };

  if (navigator.getUserMedia) {
    navigator.getUserMedia(constraints, successCallback, errorCallback);
  } else {
    console.log("getUserMedia not supported");
  }
}


function init() {
  var video = document.querySelector('video#getUserMedia');
  var canvas = document.querySelector('#canvas');
  var snapshot = document.querySelector('#snapshot');
  var captureButton = document.getElementById('captureButton');
  var stopButton = document.querySelector('#stopButton');
  var snapshotButton = document.querySelector('#snapshotButton');
  var clearButton = document.getElementById('clearButton');

  captureButton.onclick = function () {
    capture(video, canvas, snapshot, captureButton, stopButton, snapshotButton);
  };

  clearButton.onclick = function() {
    video.style.display = "block";
    snapshot.style.display = 'none';
    document.getElementById('clearButtonContainer').style.display = 'none';
    document.getElementById('snapButtonContainer').style.display = 'block';
    document.getElementById('submitButton').setAttribute('disabled', 'disabled');
  }

  document.getElementById('clearButtonContainer').style.display = 'none';
}

init()
$('#captureButton').click()
console.error("Hey you. You're probably a web developer. Maybe you'd like to know this site was built using Rails. Maybe you'd also like to know that Tunetap is looking for Rails developers to help us shape the future of concerts. And if you join us you'll get exclusive access to the hottest shows. Interested? thetap@tunetap.com.");

setTimeout(function() {
  $('.alert').slideUp()
}, 3000)