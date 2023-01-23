public with sharing class MyFirstClass {

    public Account getAccount(String name){
        return [
            SELECT Id
            FROM Account
            WHERE Name = :name
            LIMIT 1
        ];
    }
    public static Account getAccountViaStatic(String name){
        return [
            SELECT Id
            FROM Account
            WHERE Name = :name
            LIMIT 1
        ];
    }
}