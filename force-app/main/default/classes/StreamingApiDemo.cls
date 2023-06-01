public with sharing class StreamingApiDemo {
  public StreamingApiDemo() {
    System.debug(LoggingLevel.INFO, 'StreamingApiDemo');
  }

  public static Database.SaveResult sendMessage(String msg) {
    Chat__e chatEvent = new Chat__e(message__c = msg);

    Database.SaveResult result = EventBus.publish(chatEvent);
    return result;
  }
}
