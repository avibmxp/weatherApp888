<%@ WebHandler Language="C#" Class="Handler" %>

using System;
using System.Web;
using System.Data;
using System.Net;
using System.IO;
using System.Collections.Generic;
using System.Linq;
using Newtonsoft.Json.Linq;
using System.Xml.Linq;
using System.Xml.XPath;
using System.Web.SessionState;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Threading.Tasks;
using System.Net.Http.Formatting;
using System.Web.Configuration;
using Newtonsoft.Json;

public class Handler : IHttpHandler, IRequiresSessionState
{
    HttpClient client = new HttpClient();

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "application/json; charset=UTF-8";
        context.Response.AppendHeader("Access-Control-Allow-Origin", "*");
        context.Response.AppendHeader("Access-Control-Allow-Methods", "Get");
        context.Response.AppendHeader("Access-Control-Allow-Headers", "Content-Type");
        
        JObject res = new JObject();
        string route = context.Request.QueryString["route"];
        
        try
        {
            if (route != null)
            {
                switch (route)
                {
                    case "getweather":
                        {
                            string lat = context.Request.QueryString["lat"];
                            string lon = context.Request.QueryString["lon"];
                            if (lat != null && lon != null)
                            {
                                WeatherResponse weatherResponse = GetWeather(lat, lon);
                                res["payload"] = JsonConvert.SerializeObject(weatherResponse);
                                res["result"] = 1;                               
                            }
                            else
                            {
                                res["result"] = 0;
                                res["msg"] = "<No lat OR lon>";
                            }
                            break;
                        }
                }
            }
            else
            {
                res["result"] = 0;
                res["msg"] = "<No route was found>";
            }
            context.Response.Write(res.ToString());
        }
        catch (Exception ex)
        {
            res["result"] = 0;
            res["msg"] = "<ProcessRequest Failed>";
            res["errmsg"] = ex.ToString();
        }
    }

    public WeatherResponse GetWeather(string lat, string lon)
    {
        WeatherResponse weatherResponse = new WeatherResponse();
        string baseUrl = WebConfigurationManager.AppSettings["openWeatherApiUrl"];
        string key = WebConfigurationManager.AppSettings["openWeatherApiKey"];

        client.BaseAddress = new Uri(baseUrl);

        client.DefaultRequestHeaders.Accept.Add(
        new MediaTypeWithQualityHeaderValue("application/json"));

        string urlParams = string.Format("?lat={0}&lon={1}&appid={2}", lat, lon, key);
        HttpResponseMessage response = client.GetAsync(urlParams).Result;
        if (response.IsSuccessStatusCode)
        {
            weatherResponse = response.Content.ReadAsAsync<WeatherResponse>().Result;
        }
        client.Dispose();

        return weatherResponse;
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}