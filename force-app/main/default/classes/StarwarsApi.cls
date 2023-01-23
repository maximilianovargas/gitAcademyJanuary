public with sharing class StarwarsApi {
    public static HttpResponse getStarwarsPeopleByNumber(String id) {
        Http http =  new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('callout:starwarsApi/people/'+id);
        request.setMethod('GET');
        request.setHeader('Content-Type', 'application/json');
        request.setHeader('Accept', 'application/json');
        HttpResponse response = http.send(request);
        return response;
    }
}