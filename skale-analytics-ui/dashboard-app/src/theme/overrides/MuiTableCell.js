import palette from '../palette';
import typography from '../typography';

export default {
  root: {
    padding: `12px`,
    ...typography.body1,
    borderBottom: `1px solid ${palette.divider}`,
  },
  head: {
    color: palette.text.lightBlue,
    fontSize: 12
  },
};
