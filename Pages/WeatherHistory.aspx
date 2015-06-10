<%@ Page Language="C#" AutoEventWireup="true" CodeFile="WeatherHistory.aspx.cs" Inherits="Pages_WeatherHistory" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Damascus - Weather Forecast</title>
    <link rel="stylesheet" href="../CSSs/bootstrap.min.css" />
    <link rel="stylesheet" href="../CSSs/WeatherHistory.css" />
    <script type="text/javascript" src="../Scripts/jquery1.10.2.js"></script>
    <script type="text/javascript" src="../Scripts/highcharts.js"></script>
</head>
<body>
    <nav class="navbar navbar-inverse navbar-fixed-top">
        <div class="container-fluid">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="Home.aspx">
                    <span class="glyphicon glyphicon-map-marker" aria-hidden="true"></span>3alyamen
                </a>
            </div>
            <div id="navbar" class="navbar-collapse collapse">
                <ul class="nav navbar-nav navbar-right">
                    <li>
                        <a href="Home.aspx"><span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span></a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
    <!--Controls-->
    <div id="errorPanel"></div>
    <div id="container"></div>
    <div id="contentsDiv">
        <div id="SaturdayDiv" class="weatherInfoDiv" style="position: absolute;left: 35px;">
            <table class="table table-striped">
                <tr>
                    <td>
                        <h4 class="text-center">Saturday</h4>
                    </td>
                    <td>
                        <img class="text-info" id="imageWeatherSaturday">
                    </td>
                </tr>
                <tr>
                    <td>
                        <h5 class="text-warning">Description</h5>
                    </td>
                    <td>
                        <p class="text-info" id="lblWeatherDesciptionSaturday">
                    </td>
                </tr>
                <tr>
                    <td>
                        <h5 class="text-warning">Humidity</h5>
                    </td>
                    <td>
                        <p class="text-info" id="lblWeatherHumiditySaturday">
                    </td>
                </tr>
                <tr>
                    <td>
                        <h5 class="text-warning">Temperature</h5>
                    </td>
                    <td>
                        <p class="text-info" id="lblWeatherTempSaturday">
                    </td>
                </tr>
                <tr>
                    <td>
                        <h5 class="text-warningSaturday">Pressure</h5>
                    </td>
                    <td>
                        <p class="text-info" id="lblWeatherPressureSaturday">
                    </td>
                </tr>
                <tr>
                    <td>
                        <h5 class="text-warning">Wind</h5>
                    </td>
                    <td>
                        <p class="text-primary" id="lblWeatherWindSaturday">
                    </td>
                </tr>
            </table>
        </div>
        <div id="SundayDiv" class="weatherInfoDiv" style="position: absolute;top: 0px;left: 325px;">
            <table class="table table-striped">
                <tr>
                    <td>
                        <h4 class="text-center">Sunday</h4>
                    </td>
                    <td>
                        <img class="text-info" id="imageWeatherSun">
                    </td>
                </tr>
                <tr>
                    <td>
                        <h5 class="text-warning">Description</h5>
                    </td>
                    <td>
                        <p class="text-info" id="lblWeatherDesciptionSun">
                    </td>
                </tr>
                <tr>
                    <td>
                        <h5 class="text-warning">Humidity</h5>
                    </td>
                    <td>
                        <p class="text-info" id="lblWeatherHumiditySun">
                    </td>
                </tr>
                <tr>
                    <td>
                        <h5 class="text-warning">Temperature</h5>
                    </td>
                    <td>
                        <p class="text-info" id="lblWeatherTempSun">
                    </td>
                </tr>
                <tr>
                    <td>
                        <h5 class="text-warning">Pressure</h5>
                    </td>
                    <td>
                        <p class="text-info" id="lblWeatherPressureSun">
                    </td>
                </tr>
                <tr>
                    <td>
                        <h5 class="text-warning">Wind</h5>
                    </td>
                    <td>
                        <p class="text-primary" id="lblWeatherWindSun">
                    </td>
                </tr>
            </table>
        </div>
        <div id="MondayDiv" class="weatherInfoDiv" style="position: absolute;top: 0px;left: 629px;">
            <table class="table table-striped">
                <tr>
                    <td>
                        <h4 class="text-center">Monday</h4>
                    </td>
                    <td>
                        <img class="text-info" id="imageWeatherMon">
                    </td>
                </tr>
                <tr>
                    <td>
                        <h5 class="text-warning">Description</h5>
                    </td>
                    <td>
                        <p class="text-info" id="lblWeatherDesciptionMon">
                    </td>
                </tr>
                <tr>
                    <td>
                        <h5 class="text-warning">Humidity</h5>
                    </td>
                    <td>
                        <p class="text-info" id="lblWeatherHumidityMon">
                    </td>
                </tr>
                <tr>
                    <td>
                        <h5 class="text-warning">Temperature</h5>
                    </td>
                    <td>
                        <p class="text-info" id="lblWeatherTempMon">
                    </td>
                </tr>
                <tr>
                    <td>
                        <h5 class="text-warning">Pressure</h5>
                    </td>
                    <td>
                        <p class="text-info" id="lblWeatherPressureMon">
                    </td>
                </tr>
                <tr>
                    <td>
                        <h5 class="text-warning">Wind</h5>
                    </td>
                    <td>
                        <p class="text-primary" id="lblWeatherWindMon">
                    </td>
                </tr>
            </table>
        </div>
        <div id="TuesdayDiv" class="weatherInfoDiv" style=" position: absolute;top: 0px;left: 925px;">
            <table class="table table-striped">
                <tr>
                    <td>
                        <h4 class="text-center">Tuesday</h4>
                    </td>
                    <td>
                        <img class="text-info" id="imageWeatherTue">
                    </td>
                </tr>
                <tr>
                    <td>
                        <h5 class="text-warning">Description</h5>
                    </td>
                    <td>
                        <p class="text-info" id="lblWeatherDesciptionTue">
                    </td>
                </tr>
                <tr>
                    <td>
                        <h5 class="text-warning">Humidity</h5>
                    </td>
                    <td>
                        <p class="text-info" id="lblWeatherHumidityTue">
                    </td>
                </tr>
                <tr>
                    <td>
                        <h5 class="text-warning">Temperature</h5>
                    </td>
                    <td>
                        <p class="text-info" id="lblWeatherTempTue">
                    </td>
                </tr>
                <tr>
                    <td>
                        <h5 class="text-warning">Pressure</h5>
                    </td>
                    <td>
                        <p class="text-info" id="lblWeatherPressureTue">
                    </td>
                </tr>
                <tr>
                    <td>
                        <h5 class="text-warning">Wind</h5>
                    </td>
                    <td>
                        <p class="text-primary" id="lblWeatherWindTue">
                    </td>
                </tr>
            </table>
        </div>
        <div id="WednesdayDiv" class="weatherInfoDiv" style="  top: 0px;position: absolute;left: 1220px;">
            <table class="table table-striped">
                <tr>
                    <td>
                        <h4 class="text-center">Wednesday</h4>
                    </td>
                    <td>
                        <img class="text-info" id="imageWeatherWed">
                    </td>
                </tr>
                <tr>
                    <td>
                        <h5 class="text-warning">Description</h5>
                    </td>
                    <td>
                        <p class="text-info" id="lblWeatherDesciptionWed">
                    </td>
                </tr>
                <tr>
                    <td>
                        <h5 class="text-warning">Humidity</h5>
                    </td>
                    <td>
                        <p class="text-info" id="lblWeatherHumidityWed">
                    </td>
                </tr>
                <tr>
                    <td>
                        <h5 class="text-warning">Temperature</h5>
                    </td>
                    <td>
                        <p class="text-info" id="lblWeatherTempWed">
                    </td>
                </tr>
                <tr>
                    <td>
                        <h5 class="text-warning">Pressure</h5>
                    </td>
                    <td>
                        <p class="text-info" id="lblWeatherPressureWed">
                    </td>
                </tr>
                <tr>
                    <td>
                        <h5 class="text-warning">Wind</h5>
                    </td>
                    <td>
                        <p class="text-primary" id="lblWeatherWindWed">
                    </td>
                </tr>
            </table>
        </div>
        <div id="ThuresdayDiv" class="weatherInfoDiv" style="position: absolute;top: 340px;left: 418px;">
            <table class="table table-striped">
                <tr>
                    <td>
                        <h4 class="text-center">Thursday</h4>
                    </td>
                    <td>
                        <img class="text-info" id="imageWeatherThu">
                    </td>
                </tr>
                <tr>
                    <td>
                        <h5 class="text-warning">Description</h5>
                    </td>
                    <td>
                        <p class="text-info" id="lblWeatherDesciptionThu">
                    </td>
                </tr>
                <tr>
                    <td>
                        <h5 class="text-warning">Humidity</h5>
                    </td>
                    <td>
                        <p class="text-info" id="lblWeatherHumidityThu">
                    </td>
                </tr>
                <tr>
                    <td>
                        <h5 class="text-warning">Temperature</h5>
                    </td>
                    <td>
                        <p class="text-info" id="lblWeatherTempThu">
                    </td>
                </tr>
                <tr>
                    <td>
                        <h5 class="text-warning">Pressure</h5>
                    </td>
                    <td>
                        <p class="text-info" id="lblWeatherPressureThu">
                    </td>
                </tr>
                <tr>
                    <td>
                        <h5 class="text-warning">Wind</h5>
                    </td>
                    <td>
                        <p class="text-primary" id="lblWeatherWindThu">
                    </td>
                </tr>
            </table>
        </div>
        <div id="FridayDiv" class="weatherInfoDiv" style="  position: absolute;top: 340px;left: 789px;">
            <table class="table table-striped">
                <tr>
                    <td>
                        <h4 class="text-center">Friday</h4>
                    </td>
                    <td>
                        <img class="text-info" id="imageWeatherFri">
                    </td>
                </tr>
                <tr>
                    <td>
                        <h5 class="text-warning">Description</h5>
                    </td>
                    <td>
                        <p class="text-info" id="lblWeatherDesciptionFri">
                    </td>
                </tr>
                <tr>
                    <td>
                        <h5 class="text-warning">Humidity</h5>
                    </td>
                    <td>
                        <p class="text-info" id="lblWeatherHumidityFri">
                    </td>
                </tr>
                <tr>
                    <td>
                        <h5 class="text-warning">Temperature</h5>
                    </td>
                    <td>
                        <p class="text-info" id="lblWeatherTempFri">
                    </td>
                </tr>
                <tr>
                    <td>
                        <h5 class="text-warning">Pressure</h5>
                    </td>
                    <td>
                        <p class="text-info" id="lblWeatherPressureFri">
                    </td>
                </tr>
                <tr>
                    <td>
                        <h5 class="text-warning">Wind</h5>
                    </td>
                    <td>
                        <p class="text-primary" id="lblWeatherWindFri">
                    </td>
                </tr>
            </table>
        </div>
    </div>

    <script src="../Scripts/bootstrap.min.js"></script>
    <script type="text/javascript" src="../Scripts/WeatherHistory.js"></script>
</body>
</html>
