using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using FluentMigrator;

namespace CodeMigrations.Migrations.Setup
{
    [Migration(1, "Author: Robyn")]
    public class Migration_1_CreateInitialTablesWithSql : ForwardOnlyMigration
    {
        public override void Up()
        {
            Execute.EmbeddedScript("Migration_1_CreateInitialTablesWithSql.sql");
        }
    }
}
