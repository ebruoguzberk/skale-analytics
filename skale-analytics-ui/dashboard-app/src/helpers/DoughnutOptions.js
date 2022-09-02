import palette from '../theme/palette';
export const DoughnutOptions = {
  legend: {
    display: true,
    fontColor: palette.white
  },
  responsive: true,
  maintainAspectRatio: false,
  cutoutPercentage: 50,
  layout: { padding: 0 },
  tooltips: {
    enabled: true,
    mode: 'index',
    intersect: false,
    borderWidth: 1,
    borderColor: palette.divider,
    backgroundColor: palette.white,
    titleFontColor: palette.white,
    bodyFontColor:  palette.black,
    footerFontColor: palette.white,
  },
};
