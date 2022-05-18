public class AllInOneAppointment {
	//
	// TODO:
	// Add the keywords to these variables that are required to make them available 
	// in the flow builder as an Apex-defined type
	// Don't forget to add a label and a description!
	public String companyName;
	public String lastName;
	public String emailAddress;
	public DateTime appointmentTime;
	
	//
	// TODO:
	// Add the keyword that is required to make this method available in the Flow builder
	// Don't forget to add a label and a description!

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
		//
		// TODO: 	
		// Insert the accounts in the database
		// Doing so will assign the Id of each Account
		
		
		for(Integer x=0; x<allAccounts.size();x++) {
			allContacts[x].AccountId = allAccounts[x].Id;           
		}

		//
		// TODO: 	
		// Insert the Contacts in the database
		// Doing so will assign the Id of each Contact
		
		

		for(Integer x=0; x<allAccounts.size();x++) {
			allEvents[x].WhatId = allAccounts[x].Id;           
			allEvents[x].WhoId = allContacts[x].Id;           
		}
		
		//
		// TODO: 	
		// Insert the events in the database

	}
}
