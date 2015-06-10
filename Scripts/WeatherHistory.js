(function ( $ ) {

    var url = 'http://api.openweathermap.org/data/2.5/forecast/daily?q=Damascus,sy&mode=json&units=metric&cnt=7';

    $('#container').css({ position: 'absolute' });
    $('#container').css({ width: '100%' });
    $('#container').css({ top: '70px' });
    $('#container').css({ height: '90%' });
    $('#container').css({ right: '10px' });
    $('#container').css({ borderradius: '10px' });

    $.ajax({
        url:url,
        cache:false,
        dataType:'jsonp',
        success: function (response) {

            console.log(response);
            var MaxTemps = [],
                MinTemps = [],
                Degrees = [],
                Humidity = [],
                Pressure = [],
                Description = [],
                Icons = [],
                Speed = [];

            //Gathering Data
            for (var i = 0; i < response.list.length; i++) {

                MaxTemps.push(response.list[i].temp.max);
                MinTemps.push(response.list[i].temp.min);
                Degrees.push(response.list[i].deg);
                Humidity.push(response.list[i].humidity);
                Pressure.push(response.list[i].pressure);
                Description.push(response.list[i].weather[0].description);
                Icons.push(response.list[i].weather[0].icon);
                Speed.push(response.list[i].speed);

            }

            $('#container').highcharts({
                title: {
                    text: 'Damascus Forecast'
                },
                xAxis: {
                    categories: [
                        'Sunday',
                        'Monday',
                        'Tuesday',
                        'Wednesday',
                        'Thursday',
                        'Friday',
                        'Saturday',
                    ]
                },
                yAxis: {
                    plotLines: [{
                        value: 0,
                        width: 1,
                        color: '#808080'
                    }]
                },
                series: [{
                    name: 'Max Temperature',
                    data: MaxTemps
                }, {
                    name: 'Min Temperature',
                    data: MinTemps
                }, {
                    name: 'Temperature',
                    data: Degrees
                }, {
                    name: 'Humidity',
                    data: Humidity
                }, {
                    name: 'Pressure',
                    data:Pressure
                }, {
                    name: 'Wind Speed',
                    data:Speed
                }]
            });
            
            //Filling Divs

            //Saturday Div

            document.getElementById('imageWeatherSaturday').src = 'http://openweathermap.org/img/w/' + Icons[0] + '.png';
            document.getElementById('lblWeatherDesciptionSaturday').innerText = Description[0];
            document.getElementById('lblWeatherHumiditySaturday').innerText = Humidity[0] + ' %';
            document.getElementById('lblWeatherTempSaturday').innerHTML = Degrees[0] + ' F';
            document.getElementById('lblWeatherPressureSaturday').innerText = Pressure[0] + ' HPA';
            document.getElementById('lblWeatherWindSaturday').innerText = Speed[0] + ' KM';

            //Sunday

            document.getElementById('imageWeatherSun').src = 'http://openweathermap.org/img/w/' + Icons[1] + '.png';
            document.getElementById('lblWeatherDesciptionSun').innerText = Description[1];
            document.getElementById('lblWeatherHumiditySun').innerText = Humidity[1] + ' %';
            document.getElementById('lblWeatherTempSun').innerHTML = Degrees[1] + ' F';
            document.getElementById('lblWeatherPressureSun').innerText = Pressure[1] + ' HPA';
            document.getElementById('lblWeatherWindSun').innerText = Speed[1] + ' KM';

            //Monday

            document.getElementById('imageWeatherMon').src = 'http://openweathermap.org/img/w/' + Icons[2] + '.png';
            document.getElementById('lblWeatherDesciptionMon').innerText = Description[2];
            document.getElementById('lblWeatherHumidityMon').innerText = Humidity[2] + ' %';
            document.getElementById('lblWeatherTempMon').innerHTML = Degrees[2] + ' F';
            document.getElementById('lblWeatherPressureMon').innerText = Pressure[2] + ' HPA';
            document.getElementById('lblWeatherWindMon').innerText = Speed[2] + ' KM';

            //Tuesday


            document.getElementById('imageWeatherTue').src = 'http://openweathermap.org/img/w/' + Icons[3] + '.png';
            document.getElementById('lblWeatherDesciptionTue').innerText = Description[3];
            document.getElementById('lblWeatherHumidityTue').innerText = Humidity[3] + ' %';
            document.getElementById('lblWeatherTempTue').innerHTML = Degrees[3] + ' F';
            document.getElementById('lblWeatherPressureTue').innerText = Pressure[3] + ' HPA';
            document.getElementById('lblWeatherWindTue').innerText = Speed[3] + ' KM';

            //Wednesday

            document.getElementById('imageWeatherWed').src = 'http://openweathermap.org/img/w/' + Icons[4] + '.png';
            document.getElementById('lblWeatherDesciptionWed').innerText = Description[4];
            document.getElementById('lblWeatherHumidityWed').innerText = Humidity[4] + ' %';
            document.getElementById('lblWeatherTempWed').innerHTML = Degrees[4] + ' F';
            document.getElementById('lblWeatherPressureWed').innerText = Pressure[4] + ' HPA';
            document.getElementById('lblWeatherWindWed').innerText = Speed[4] + ' KM';

            //Thursday


            document.getElementById('imageWeatherThu').src = 'http://openweathermap.org/img/w/' + Icons[5] + '.png';
            document.getElementById('lblWeatherDesciptionThu').innerText = Description[5];
            document.getElementById('lblWeatherHumidityThu').innerText = Humidity[5] + ' %';
            document.getElementById('lblWeatherTempThu').innerHTML = Degrees[5] + ' F';
            document.getElementById('lblWeatherPressureThu').innerText = Pressure[5] + ' HPA';
            document.getElementById('lblWeatherWindThu').innerText = Speed[5] + ' KM';

            //Friday


            document.getElementById('imageWeatherFri').src = 'http://openweathermap.org/img/w/' + Icons[6] + '.png';
            document.getElementById('lblWeatherDesciptionFri').innerText = Description[6];
            document.getElementById('lblWeatherHumidityFri').innerText = Humidity[6] + ' %';
            document.getElementById('lblWeatherTempFri').innerHTML = Degrees[6] + ' F';
            document.getElementById('lblWeatherPressureFri').innerText = Pressure[6] + ' HPA';
            document.getElementById('lblWeatherWindFri').innerText = Speed[6] + ' KM';

        },
        error: function (error) {
            alert(error);
            document.getElementById('contentsDiv').style.display = 'none';
            document.getElementById('errorPanel').style.display = 'block';
        }
    })

}(jQuery));