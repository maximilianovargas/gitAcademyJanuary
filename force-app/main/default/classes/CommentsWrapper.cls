public with sharing class CommentsWrapper {

    public Integer postId;
    public Integer id;
    public String name;
    public String email;
    public String body;
    

    
    public static List<CommentsWrapper> parse(String json) {
        return (List<CommentsWrapper>) System.JSON.deserialize(json, List<CommentsWrapper>.class);
    }
    
}