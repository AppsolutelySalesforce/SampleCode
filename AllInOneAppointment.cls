public class AllInOneAppointment {
    @auraEnabled
    @InvocableVariable(label='Company Name' description='Name of the company')
		public String companyName;
    @auraEnabled
    @InvocableVariable(label='Last Name' description='Last Name of the person to meet with')
    public String lastName;
    @auraEnabled
    @InvocableVariable(label='Email' description='Email of the person to meet with')
    public String emailAddress;
    @auraEnabled
    @InvocableVariable(label='Appointment time' description='Time to do the meeting')
    public DateTime appointmentTime;
    
		@InvocableMethod(label='Quick create an appointment' description='Creates Account, Contact and an Event')
  	public static void quickCreateMeetings(List<AllInOneAppointment> appointments) {
        List<Account> allAccounts = new List<Account>();
        List<Contact> allContacts = new List<Contact>();
        List<Event> allEvents = new List<Event>();
        for(AllInOneAppointment anAppointment : appointments) {
            Account acc = new Account(Name=anAppointment.companyName);
            Contact con = new Contact(LastName=anAppointment.lastName, Email=anAppointment.emailAddress);
            Event ev = new Event(Subject='Meet with '+anAppointment.lastName, ActivityDateTime=anAppointment.appointmentTime, DurationInMinutes=60);
						allAccounts.add(acc);
            allContacts.add(con);
            allEvents.add(ev);
        }
        insert allAccounts;
        for(Integer x=0; x<allAccounts.size();x++) {
					allContacts[x].AccountId = allAccounts[x].Id;           
        }
        insert allContacts;
        for(Integer x=0; x<allAccounts.size();x++) {
					allEvents[x].WhatId = allAccounts[x].Id;           
					allEvents[x].WhoId = allContacts[x].Id;           
        }
        insert allEvents;
    }
}
