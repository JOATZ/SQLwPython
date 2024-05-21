"""not null customers date_of_birth

Revision ID: 87e63d25db5f
Revises: c49cbcf43689
Create Date: 2024-05-16 11:28:11.365372

"""
from typing import Sequence, Union

from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision: str = '87e63d25db5f'
down_revision: Union[str, None] = 'c49cbcf43689'
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade():
    op.execute(
        """
        ALTER TABLE customers
        ALTER COLUMN date_of_birth SET NOT NULL;
        """
    )


def downgrade():
    op.execute(
        """
        ALTER TABLE customers
        ALTER COLUMN date_of_birth DROP NOT NULL;
        """
    )
