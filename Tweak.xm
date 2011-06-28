#import <sqlite3.h>
#import <UIKit/UIKit.h>

static NSString *canIHazRandomQuotePl0x() {

	sqlite3 *quoteDatabase = NULL;

	sqlite3_open("/Library/Application Support/Quoter/quotes.db", &quoteDatabase);
	
	if (!quoteDatabase)
		return @"Error1";
	
	sqlite3_stmt *statement = NULL;
	
	sqlite3_prepare_v2(quoteDatabase, "select count(quote) from quotes;", -1, &statement, NULL);
	
	if (!statement) {
		sqlite3_close(quoteDatabase);
		return @"Error2";
	}

	int count = 0;
	
	while (sqlite3_step(statement) == SQLITE_ROW) {
		
		count = sqlite3_column_int(statement, 0);
		
	}
	
	int where = arc4random() % count;
	
	if (sqlite3_finalize(statement) != SQLITE_OK) {
		sqlite3_close(quoteDatabase);
		return @"Error3";
	}
	
	statement = NULL;
	
	sqlite3_prepare_v2(quoteDatabase, [[NSString stringWithFormat:@"select quote from quotes where id = %i;", where] UTF8String] , -1, &statement, NULL);
	
	if (!statement) {
		sqlite3_close(quoteDatabase);
		return @"Error4";
	}
	
	NSString *zQuote = nil;
	
	while (sqlite3_step(statement) == SQLITE_ROW) {
		
		zQuote = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
		
	}
	
	sqlite3_close(quoteDatabase);
	
	return zQuote ? : @"Error5";
}

static NSDate *noTimePl0x(NSDate *datDate) {
	
	if( datDate == nil ) {
        datDate = [NSDate date];
    }
    NSDateComponents* comps = [[NSCalendar currentCalendar] components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:datDate];
    return [[NSCalendar currentCalendar] dateFromComponents:comps];
	
}

static BOOL canShowZeAlert() {
	
	NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/com.thezimm.quoter.plist"] ?: [[NSMutableDictionary alloc] init];
	
	NSDate *lastDate = [prefs objectForKey:@"lastDate"] ? : [NSDate dateWithTimeIntervalSinceNow:-86400];
	
	NSDate *zDate = noTimePl0x(nil);
	
	if ([zDate compare:noTimePl0x(lastDate)] == NSOrderedDescending) {
		
		[prefs setObject:zDate forKey:@"lastDate"];
		
		[prefs writeToFile:@"/var/mobile/Library/Preferences/com.thezimm.quoter.plist" atomically:YES];
		
		[prefs release];
		
		return YES;
		
	} else {
		
		[prefs release];
		
		return NO;
		
	}
	
}

static void pl0xAlert() {
	if (canShowZeAlert()) {
		
		UIAlertView *zAlert = [[UIAlertView alloc] initWithTitle:@"Quote!" message:canIHazRandomQuotePl0x() delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
		
		[zAlert show];
		
		[zAlert release];
		
	}
}

%hook SBAwayController

-(void)unlockWithSound:(BOOL)sound
{
	%orig;
	
	pl0xAlert();
}

-(void)_sendToDeviceLockOwnerDeviceUnlockSucceeded
{
	%orig;
	
	pl0xAlert();
}


%end













