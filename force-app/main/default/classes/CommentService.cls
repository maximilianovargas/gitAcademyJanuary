public with sharing class CommentService {
    public static HttpResponse getComments(String externalId) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setMethod('GET');
        request.setEndpoint('callout:jsonplaceholder/posts/'+externalId+'/comments');
        request.setHeader('Content-Type', 'application/json');
        HttpResponse response = http.send(request);
        return response;
    }
}