codeunit 50252 UpdateBookStatusOnLoad
{

    trigger OnRun()
    var
        books: Record Library;
        Today: Date;
        rentedBooks: Record BookTransactions;
    begin
         if books.FindSet() then

            repeat
            //Checking if the current book status is not set to pending grading or archived, this will ensure that records with these statuses are not updated.
            if (books.Status <> enum::Statuses::"Pending Grading") and (books.Status <> enum::Statuses::Archived) then
            begin

                if (books.Grade = enum::Grades::D) and (books.Status <> enum::Statuses::"Out for repair") then begin
                    //Update book status
                    books.Validate(Status, Statuses::"Out for repair");
                    books.Modify();
                    //Add Log to show status history.
                    Rec.AddLogs(Statuses::"Out for repair");
                end;

                
                if (books."Rented Count" <> 0) and (books.Grade <> enum::Grades::D) then begin
                    rentedBooks.SetRange("Book ID", books."Book ID");
                    //Check if there are any previous book records. If not, the book status will be updated to available.
                    if rentedBooks.Count() > 0 then 
                    begin
                    rentedBooks.SetCurrentKey("Date Rented");
                    rentedBooks.Ascending();
                    if rentedBooks.FindFirst() then begin
                        if rentedBooks."Return Date" < Today() then begin
                            if rentedBooks.Status = enum::Statuses::Rented then begin
                                if (rentedBooks."Return Date" <> 0D) and (books.Status <> enum::Statuses::Overdue) then begin
                                    //Update book status
                                    books.Validate(Status, Statuses::Overdue);
                                    books.Modify();
                                    //Add Log to show status history.
                                    Rec.AddLogs(Statuses::Overdue);
                                end;
                            end;
                        end;
                    end;
                    end;
                    if (rentedBooks.Count() = 0) and (books.Status <> enum::Statuses::Available) then 
                    begin
                        //Update book status
                        books.Status := enum::Statuses::Available;
                        books.Modify();
                        //Add Log to show status history.
                        Rec.AddLogs(Statuses::Available);
                    end;
                end;

                if (books."Rented Count" = 0) and (books.Grade <> enum::Grades::D) and (books.Status <> enum::Statuses::Available) then begin
                    //Update book status
                    books.Validate(Status, Statuses::Available);
                    books.Modify();
                    //Add Log to show status history.
                    Rec.AddLogs(Statuses::Available);
                end;
                end;
            until books.Next() = 0;
    end;
}