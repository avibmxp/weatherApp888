using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for weather
/// </summary>
public class WeatherResponse
{
    public Coord coord { get; set; }
    public List<Weather> weather { get; set; }
    public Main main { get; set; }
    public int visibility { get; set; }
    public int dt { get; set; }
    public Sys sys { get; set; }
    public int timezone { get; set; }
    public int id { get; set; }
    public string name { get; set; }
    public int cod { get; set; }
}
public class Coord
{
    public string lon { get; set; }
    public string lat { get; set; }
}
public class Main
{
    public string temp { get; set; }
    public string feels_like { get; set; }
    public string temp_min { get; set; }
    public string temp_max { get; set; }
    public string pressure { get; set; }
    public string humidity { get; set; }
    public string sea_level { get; set; }
    public string grnd_level { get; set; }
}
public class Sys
{
    public string type { get; set; }
    public string id { get; set; }
    public string country { get; set; }
    public string sunrise { get; set; }
    public string sunset { get; set; }
}
public class Weather
{
    public string id { get; set; }
    public string main { get; set; }
    public string description { get; set; }
    public string icon { get; set; }
}