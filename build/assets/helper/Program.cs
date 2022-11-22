using System;
using System.IO;
using System.Linq;
using Newtonsoft.Json.Linq;

namespace json_updater
{
    class Program
    {
        static void Main(string[] args)
        {
            var configPath = args.Skip(0).FirstOrDefault() ?? throw new ArgumentNullException("missing args[0] as config path");
            var nodePath = args.Skip(1).FirstOrDefault() ?? throw new ArgumentNullException("missing args[1] as node path");
            var updateValue = args.Skip(2).FirstOrDefault() ?? throw new ArgumentNullException("missing args[2] as update value");
            
            var jsonContent = File.ReadAllText(configPath);
            var jsonObj = JObject.Parse(jsonContent);
            var targetNode = jsonObj.SelectToken(nodePath) as JValue ?? throw new Exception("missing value node");
            targetNode.Value = updateValue;
            
            var jsonUpdated = jsonObj.ToString();
            File.WriteAllText(configPath, jsonUpdated);
        }
    }
}
