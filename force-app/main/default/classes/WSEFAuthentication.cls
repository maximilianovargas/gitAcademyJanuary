public with sharing class WSEFAuthentication {
    private static final Webservice_endpoint_setting__mdt SERVICE_CONFIG =
		ConfigUtils.getWebServiceConfig('token');

	public static Response getToken() {
		Response result = new Response();

		RestWS ws = new RestWS('callout:servicioEjercicio/token', 'POST', null);
        string body = '{"USER":'+SERVICE_CONFIG.User__c+', "PASS:"'+SERVICE_CONFIG.Pass__c+'}';
		ws.request.setBody(body);


		return (Response) ws.invoke(result);		
	}

	public static void setAuth(RestWS ws) {
		Response tokenAuth = getToken();
		if(tokenAuth.token == null) {
			ws.hasError = true;
			ws.errorMessage = 'No pudo autorizarse';				
		} else {
			ws.request.setHeader('Authorization', 'Bearer ' + tokenAuth.token.token);
		}
	}

	public class Response extends WSResult {
		public WSResponse.WSToken token;
		public override void processResponse(HttpResponse response) {
			token = (WSResponse.WSToken)
				JSON.deserialize(response.getBody(), WSResponse.WSToken.class);
		}

		public override void processErrorResponse(HttpResponse response) {
			
		}
	}
}