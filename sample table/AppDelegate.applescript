--
--  AppDelegate.applescript
--  sample table
--
--  Created by John Welch on 9/13/18.
--  Copyright © 2018 John Welch. All rights reserved.
--

script AppDelegate
	property parent : class "NSObject"
	property theTestTableControllerArray: {} --exists just in case we need to manipulate the array differently from using the referencing outlet for the array controller. Rarely used. This binding is done in the bindings property for the Array Controller. 
	
	property theTestTableController: missing value --referencing outlet for the array controller. The array controller is what we're going to use to control the table, including adding and/or removing items. This binding is done via ctrl-drag from the popup menu for the array controller to the delegate. Note that the array controller's name changes to match this property.
	
	property theTestTableView: missing value --referencing outlet for the table view. ctrl-drag from the table view to get this attached.
	
	property theSourceRecord:{}
	property theTableData:{}
	(*table notes:
	 note that for the table columns, those names are set in the attribute inspector as the titles for the columns. I also remove the table cell view, leaving only the text cell. That's helped me avoid a lot of annoyances. That's not an "always do", but for my uses, it's worked.
	 
	 you also want to make the Delegate object a delegate of the table view, (the view is right below the clip view as you expand the triangles for the table.) This helps you track if someone is moving through the table via arrow up/down keys.
	 *)
	
	
	-- IBOutlets
	property theWindow : missing value
	
	on applicationWillFinishLaunching_(aNotification)
		--so now, we create a small NSData Object that is a list of records with source data for the table. In general, I try to use "proper" cocoa structures for things, it can avoid odd errors that happen with records and lists, and it helps the documentation make more sense.
		
		
		set my theSourceRecord to {{col1:"column one",col2:"column2"},{col1:"row one",col2:"row2"}} --AppleScript list of records
		set my theTableData to current application's NSData's dataWithData:theSourceRecord --NSData object of NSArrays
		my theTestTableController's removeObjects:(my theTestTableController's arrangedObjects()) --clear out any pre-existing data in the array controller. This is important to filling the table and not perpetually appending data accidently. Especially on first load.
		my theTestTableController's addObjects:my theTableData --load the table from the table data
		my theTestTableController's setSelectionIndex:0 --this just sets the selected item in the table to the first row. Completely optional based on need.
		
		log my theTableData
	end applicationWillFinishLaunching_
	
	on tableClicked:sender --bound to action for the table view via ctrl-drag to the Delegate. Note, even in the case of a double-click, this ALWAYS fires, so keep that in mind when having separate things for click and doubleclick on an item in the table
		log "click"
	end tableClicked:
	
	on tableDoubleClicked:sender --bound to double action for the table view
		log "doubleclick"
	end tableDoubleClicked:
	
	on tableViewSelectionDidChange:(sender) --This is enabled by linking the Delegate property for the table view to the app Delegate in IB. This allows you to keep track of selection changes via arrow keys. note that this ALSO fires if you click in a row, ALONG WITH the action function. so if you have a separate action and double action function, a doubleclick will fire all three. 
		log "changed"
	end tableViewSelectionDidChange:
		
	
	on applicationShouldTerminate_(sender)
		-- Insert code here to do any housekeeping before your application quits 
		return current application's NSTerminateNow
	end applicationShouldTerminate_
	
	on applicationShouldTerminateAfterLastWindowClosed:sender
		true
	end applicationShouldTerminateAfterLastWindowClosed:
	
end script
