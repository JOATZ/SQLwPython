"""add customers date_of_birth

Revision ID: c49cbcf43689
Revises: d5d55c33d9c8
Create Date: 2024-05-16 11:23:31.130281

"""
from typing import Sequence, Union

from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision: str = 'c49cbcf43689'
down_revision: Union[str, None] = 'd5d55c33d9c8'
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade():
    op.execute(
        """
        ALTER TABLE customers
        ADD COLUMN date_of_birth TIMESTAMP;
        """
    )


def downgrade():
    op.execute(
        """
        ALTER TABLE customers
        DROP COLUMN date_of_birth;
        """
    )
