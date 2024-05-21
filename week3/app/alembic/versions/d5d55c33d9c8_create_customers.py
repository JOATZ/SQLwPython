"""create customers

Revision ID: d5d55c33d9c8
Revises: 
Create Date: 2024-05-16 11:21:04.755282

"""
from typing import Sequence, Union

from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision: str = 'd5d55c33d9c8'
down_revision: Union[str, None] = None
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade():
    op.execute(
        """
        CREATE TABLE customers(
            id SERIAL PRIMARY KEY,
            name TEXT NOT NULL
        );
        """
    )

def downgrade():
    op.execute(
        """
        DROP TABLE customers;
        """
    )
