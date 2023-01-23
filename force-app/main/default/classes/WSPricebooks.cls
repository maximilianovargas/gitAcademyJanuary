public with sharing class WSPricebooks {

    public static Response getPricebooks() {
        Response result = new Response();

        RestWS ws = new RestWS('callout:servicioEjercicio/listas', 'GET', null);
        WSEFAuthentication.setAuth(ws);
        return (response) ws.invoke(result);
    }

    public class Response extends WSResult {
		public List<WSResponse.WSPricebook> pricebooks;
		public override void processResponse(HttpResponse response) {
			pricebooks = (List<WSResponse.WSPricebook>)
				JSON.deserialize(response.getBody(), List<WSResponse.WSPricebook>.class);
		}

        public override void processErrorResponse(HttpResponse response) {
            
		}
	}
}