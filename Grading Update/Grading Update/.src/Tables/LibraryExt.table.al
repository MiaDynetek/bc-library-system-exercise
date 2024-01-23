tableextension 50250 "Library Ext - Procedures" extends Library
{
    fields
    {
        // Add changes to table fields here
    }
    
    keys
    {
        // Add changes to keys here
    }
    
    fieldgroups
    {
        // Add changes to field groups here
    }
    procedure FilterReceivingRepair()

    begin
        Rec.SetRange(Status, enum::Statuses::"Out for repair");
    end;
    procedure ArchiveBook()
    var

    begin
        Rec.Status := enum::Statuses::Archived;
        Rec.Modify();
        Message('The book you selected have been set to Archived.');
        Rec.AddLogs(enum::Statuses::Archived);
    end;


    procedure AddLogs(CurrStatus : enum Statuses)
    var
        newLog: Record BookTransactions;
    begin
        newLog.Init();
        newLog."Book Name" := Rec.Title;
        newLog."Book ID" := Rec."Book ID";
        newLog.Validate(Status, CurrStatus);
        newLog.Grade := Rec.Grade;
        newLog."Grade Justification" := Rec."Grade Justification";
        newLog.Insert();
    end;
    var
        myInt: Integer;
}