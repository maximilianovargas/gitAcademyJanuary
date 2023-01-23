@isTest
private with sharing class GetCommentsScheduleTest {
    @isTest
     static void whenTheScheduleBatchGetCommentIsScheduled() {
		String chron = '0 30 2 1/1 * ? *';

		Test.startTest();
		String jobId = System.schedule('Schedule GetCommentsTEST', chron, new GetCommentsSchedule());
		Test.stopTest();

		CronTrigger cronTrigger = [
			SELECT id , CronExpression, NextFireTime
			FROM CronTrigger
			WHERE id = :jobId
		];

		Integer doItTomorrowOrToday = (System.now().time() > Time.newInstance(2, 30, 0, 0)) ? 1 : 0;
		Date aDate = Date.today().addDays(doItTomorrowOrToday);
		Time aTime = Time.newInstance(2, 30, 0, 0);
		Datetime nextFireTime = Datetime.newInstance(aDate, aTime);

		System.assertEquals(chron, cronTrigger.CronExpression);
		System.assertEquals(nextFireTime, cronTrigger.NextFireTime);
	}
}