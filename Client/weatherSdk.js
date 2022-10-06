(function (window) {
  // declare
  var weatherSdk = function () {
    return;
  };

  weatherSdk.prototype.calc = function (context, onComplete, onError) {
    let lattitude = context.lattitude;
    let longitude = context.longitude;

    if (lattitude && longitude) {
      fetch(
        `http://localhost:1409/Services/Handler.ashx?route=getweather&lat=${lattitude}&lon=${longitude}`
      )
        .then((response) => response.json())
        .then((json) => {
          if (json.result == 1) {
            let payload = JSON.parse(json.payload);
            let tempInCel = `${Math.floor(payload.main.temp - 273.15)}C`;
            onComplete(payload.name, tempInCel, payload.sys.country);
          } else {
            onError("API response error");
          }
        })
        .catch((error) => {
          onError(error);
        });
    } else {
      onError("Lattitude OR/AND Longitude are missing");
    }
  };
  window.weatherSdk = new weatherSdk();
})(window, undefined);
