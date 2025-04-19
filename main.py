from icecream import ic
import sqlite3 as sql


class Database:
    def __init__(self, path: str) -> None:
        self.path: str = path
        
        self.connection: sql.Connection = sql.connect(self.path)
        self.connection.row_factory = self.dict_factory
        self.cursor: sql.Cursor = self.connection.cursor()
        
    def dict_factory(self, cursor: sql.Cursor, row: sql.Row) -> dict:
        """Transforms row to a dict object

        Args:
            cursor (sql.Cursor): Database cursor
            row (sql.Row): Current selected row

        Returns:
            dict: A simple dict containing row name & value {'id': 1}
        """
        d: dict = {}
        for idx, col in enumerate(cursor.description):
            d[col[0]] = row[idx]
        return d
    
    def get_table(self, table_name: str) -> list[dict]:
        """Returns all table content

        Args:
            table_name (str): Table name

        Returns:
            list[dict]: a list with dict content. example: [{'id': 1, 'name': 'John Doe'}]
        """
        
        self.cursor.execute(f"SELECT * FROM {table_name}")
        return self.cursor.fetchall()




class MessageApp:
    def __init__(self) -> None:
        pass


def main() -> None:
    db = Database("database.db")
    message_app: MessageApp = MessageApp()
    
    profiles = ic(db.get_table("profile"))
    chats = ic(db.get_table("chat"))
    messages = ic(db.get_table("message"))

if __name__ == "__main__":
    main()