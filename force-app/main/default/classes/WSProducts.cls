public with sharing class WSProducts {

    public static Response getProducts() {
        Response result = new Response();

        RestWS ws = new RestWS('callout:servicioEjercicio/productos', 'GET', null);
        WSEFAuthentication.setAuth(ws);
        return (Response) ws.invoke(result);
    }

    public class Response extends WSResult {
		public List<WSResponse.WSProduct> products;
		public override void processResponse(HttpResponse response) {
			products = (List<WSResponse.WSProduct>)
				JSON.deserialize(response.getBody(), List<WSResponse.WSProduct>.class);
		}

        public override void processErrorResponse(HttpResponse response) {
            
		}
	}
    
}