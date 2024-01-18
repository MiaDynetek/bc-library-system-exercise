page 50711 "Open Library"
{
    Caption = 'Open Library';
    PageType = CardPart;
    
    
    layout
    {
        area(content)
        {
            cuegroup(CustomerOverviewListContainer)
            {
                Caption = 'View Library Books';
                actions
                {
                    action("Open Library Book List")
                    {
                        ApplicationArea = All;
                        
                        Image = TileGreen;
                        
                        trigger OnAction()
                        var
                            Library: Record Library;
                        begin
                            Library.OpenLibraryPage();
                        end;
                    }
                }
            }
        }
    }

 
}
