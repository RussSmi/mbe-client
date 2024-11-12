using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Azure.Functions.Worker;
using Microsoft.Extensions.Logging;

namespace My.Demos
{
    public class client_function
    {
        private readonly ILogger<client_function> _logger;

        public client_function(ILogger<client_function> logger) 
        {
            _logger = logger;
        }

        [Function("client_function")]
        public async Task<IActionResult> Run([HttpTrigger(AuthorizationLevel.Anonymous, "post")] HttpRequest req)
        {
            _logger.LogInformation("C# HTTP trigger function processed a request.");

            // Read API Url from app settings
            var apiUrl = Environment.GetEnvironmentVariable("API_URL");

            // pass the request body to api
            var client = new HttpClient();
            var response = await client.PostAsync(apiUrl, new StringContent(await new StreamReader(req.Body).ReadToEndAsync()));
            var responseContent = await response.Content.ReadAsStringAsync();

            return new OkObjectResult(responseContent);
        }
    }
}
 