
import asyncio
from contextlib import asynccontextmanager
from typing import AsyncGenerator, Optional, List

from sqlalchemy import Column, ForeignKey, Integer, String
from sqlalchemy.orm import relationship, sessionmaker, Mapped
from sqlalchemy.ext.asyncio import AsyncSession, create_async_engine
from sqlalchemy.ext.declarative import declarative_base


Base = declarative_base()


class Author(Base):
    __tablename__ = "authors"
    id: int = Column(Integer, primary_key=True, index=True)
    name: str = Column(String, nullable=False, unique=True)

    books: Mapped[List["Book"]] = relationship("Book", lazy="joined", back_populates="author")


class Book(Base):
    __tablename__ = "books"
    id: int = Column(Integer, primary_key=True, index=True)
    name: str = Column(String, nullable=False)
    author_id: Optional[int] = Column(Integer, ForeignKey(Author.id), nullable=True)

    author: Mapped[Optional[Author]] = relationship(Author, lazy="joined", back_populates="books")



### DOCKER CONNECTION ###

# engine = create_async_engine(
#     "sqlite+aiosqlite:///./database.db", connect_args={"check_same_thread": False}
# )

user = "mbroms"
pw = "hello123"
path = "127.0.0.1:5432"
db = "booksandauthors"
engine = create_async_engine("postgresql+asyncpg://{u}:{pw}@{path}/{db}"
                             .format(u=user, pw=pw, path=path, db=db))

async_session = sessionmaker(
    bind=engine,
    class_=AsyncSession,
    expire_on_commit=False,
    autocommit=False,
    autoflush=False,
)

@asynccontextmanager
async def get_session() -> AsyncGenerator[AsyncSession, None]:
    async with async_session() as session:
        async with session.begin():
            try:
                yield session
            finally:
                await session.close()

async def _async_main():
    async with engine.begin() as conn:
        await conn.run_sync(Base.metadata.drop_all)
        await conn.run_sync(Base.metadata.create_all)
    await engine.dispose()


if __name__ == "__main__":
    print("Dropping and creating tables")
    asyncio.run(_async_main())
    print("Done.")