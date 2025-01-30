"""your migration name here

Revision ID: 56ad4dd7f39c
Revises: 2f3b23c0b1f0
Create Date: 2025-01-30 11:21:00.917471

"""

from typing import Sequence, Union

# revision identifiers, used by Alembic.
revision: str = "56ad4dd7f39c"
down_revision: Union[str, None] = "2f3b23c0b1f0"
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    pass


def downgrade() -> None:
    pass
