//
//  DatabaseLayer.m
//  AKSStore
//
//  Created by surya on 9/18/17.
//  Copyright © 2017 surya. All rights reserved.
//

#import "DatabaseLayer.h"
#import <sqlite3.h>


@interface DatabaseLayer()

@property (nonatomic, strong) NSString *docDirectory;
@property (nonatomic, strong) NSString *myDBName;
@property (nonatomic, strong) NSMutableArray *arrResults;


-(void)runQuery:(const char *)query isExecutable:(BOOL)qExecutable;
-(void)copyDBToDocuments;

@end

@implementation DatabaseLayer

-  (instancetype)initWithDatabase:(NSString *)myDB
{
    self = [super init];
    
    if(self)
    {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        self.docDirectory = [paths objectAtIndex:0];
        
        self.myDBName = myDB;
        
        [self copyDBToDocuments];
    }
    return self;
}


- (void) copyDBToDocuments
{
    NSString *destinationPath = [self.docDirectory stringByAppendingPathComponent:self.myDBName];
    if (![[NSFileManager defaultManager] fileExistsAtPath:destinationPath]) {
        NSString *sourcePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:self.myDBName];
        NSError *error;
        [[NSFileManager defaultManager] copyItemAtPath:sourcePath toPath:destinationPath error:&error];
        
        
        if(error != nil)
        {
            NSLog(@"%@",[error localizedDescription]);
        }
    }
}

-(void) runQuery:(const char *)query isExecutable:(BOOL)qExecutable
{
    sqlite3 *sqliteDB;
    
    NSString *dbPath = [self.docDirectory stringByAppendingPathComponent:self.myDBName];
    
    if (self.arrResults!= nil) {
        [self.arrResults removeAllObjects];
        self.arrResults = nil;
    }
    self.arrResults = [[NSMutableArray alloc] init];
    
    if (self.arrColNames != nil) {
        [self.arrColNames removeAllObjects];
        self.arrColNames = nil;
    }
    self.arrColNames = [[NSMutableArray alloc] init];
    
    BOOL openDbResult = sqlite3_open([dbPath UTF8String], &sqliteDB);
    
    if (openDbResult == SQLITE_OK)
    {
        
        sqlite3_stmt *compiledStatement;
        
        BOOL prepStatementResult = sqlite3_prepare_v2(sqliteDB, query, -1, &compiledStatement, NULL);
        
        if (prepStatementResult == SQLITE_OK)
        {
            if(!qExecutable)
            {
                NSMutableArray *arrDataRow;
                
                while (sqlite3_step(compiledStatement) == SQLITE_ROW) {
                    arrDataRow = [[NSMutableArray alloc] init];
                }
                
                int totalCols = sqlite3_column_count(compiledStatement);
                
                for (int i=0; i<totalCols; i++){
                    char *dbDataAsChars = (char *)sqlite3_column_text(compiledStatement, i);
                    
                    if (dbDataAsChars != NULL) {
                        [arrDataRow addObject:[NSString  stringWithUTF8String:dbDataAsChars]];
                    }
                    
                    if (self.arrColNames.count != totalCols) {
                        dbDataAsChars = (char *)sqlite3_column_name(compiledStatement, i);
                        [self.arrColNames addObject:[NSString stringWithUTF8String:dbDataAsChars]];
                    }
                }
                
                if (arrDataRow.count > 0) {
                    [self.arrResults addObject:arrDataRow];
                }
            }
            else
            {
                BOOL executeQueryResults = sqlite3_step(compiledStatement);
                if (executeQueryResults == SQLITE_DONE) {
                    self.rowsChanged = sqlite3_changes(sqliteDB);
                    
                    self.lastInsertedRowID = sqlite3_last_insert_rowid(sqliteDB);
                }
                else {
                    NSLog(@"DB Error: %s", sqlite3_errmsg(sqliteDB));
                }
            }

        }
        else
        {
            NSLog(@"%s", sqlite3_errmsg(sqliteDB));
        }
        sqlite3_finalize(compiledStatement);
    }
    
    sqlite3_close(sqliteDB);
}

- (NSArray *)loadData:(NSString *)query
{
    [self runQuery:[query UTF8String] isExecutable:NO];
    
    return (NSArray *)self.arrResults;
    
}

-(void) executeQuery:(NSString *)query
{
    [self runQuery:[query UTF8String] isExecutable:YES];
}

@end
