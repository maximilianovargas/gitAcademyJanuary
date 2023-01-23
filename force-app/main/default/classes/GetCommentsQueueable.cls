public with sharing class GetCommentsQueueable implements Queueable,Database.AllowsCallouts {
    public List<Post__c> posts;
    public GetCommentsQueueable(List<Post__c> posts) {
        this.posts = posts;
    }
    public void execute(QueueableContext context) {
        if (this.posts.isEmpty()) {
            return;
        }
        Post__c aPost = this.posts.remove(0);
        HttpResponse response  = CommentService.getComments(aPost.External_Id__c);
        Map<String,Comment__c> commentsByEmail = new Map<String,Comment__c>();
        if (response.getStatusCode() == 200) {
            List<CommentsWrapper> commentsWrapper = CommentsWrapper.parse(response.getBody());
            for (CommentsWrapper commentWrapper : commentsWrapper) {
                commentsByEmail.put(
                    commentWrapper.email.toLowerCase(),
                    new Comment__c(
                        External_Id__c = String.valueOf(commentWrapper.Id),
                        Post__c = aPost.Id,
                        Email__c = commentWrapper.email,
                        Body__c = commentWrapper.body
                    )
                );
            }

            List<Contact> contacts = [
                SELECT Id, Email
                FROM Contact
                WHERE Email IN :commentsByEmail.keySet()
            ];

            for (Contact aContact : contacts) {
                Comment__c aComment = commentsByEmail.get(aContact.Email);
                aComment.Contact__c = aContact.Id;
            }

            insert commentsByEmail.values();

            if (this.posts.size() > 0 && !Test.isRunningTest()) {
                GetCommentsQueueable queueable = new GetCommentsQueueable(this.posts);
                System.enqueueJob(queueable);
            }
        }
        
    }
}