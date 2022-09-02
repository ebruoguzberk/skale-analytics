import { colors } from '@material-ui/core';

const white = '#FFFFFF';
const black = '#000000';
const blue = '#2424a7';
const lightBlue = '#00aeef';


export default {
  black,
  white,
  blue,
  primary: {
    contrastText: white,
    dark: '#000000',
    main: '#A1A2B4',
    normal: '#7A77FF',
    action: '#4949ff6b',
    actionHeader: '#1d3fa6',
    light: '#060606',
    medium: '#060606',
  },
  secondary: {
    contrastText: white,
    dark: '#2528A9',
    main: '#9EF446',
    light: '#2525A6',
    lighten: '#90EB61',
    secondary19: '#53CAB4',
    secondary4: '#2472CF',
    secondary5: '#274DBD',
    secondary6: '#00F794',
    secondary3: '#2527A8',
    secondary7: '#46C2C1',
    secondary8: '#275FC5',
    secondary9: '#74DB8B',
    secondary10: '#06AEED',
    secondary11: '#9EF446',
    secondary12: '#2740B4',
    secondary13: '#5CCFAA',
    secondary14: '#237AD4',
    secondary15: '#7EE07D',
    secondary16: '#20B4E1',
    secondary17: '#8FEB62',
    secondary18: '#3BBECD',
  },
  chart: {
    borderOne: "rgba(0, 246, 148, 1)",
    backgroundOne: "rgba(0, 246, 148, 0.4)"
  },
  success: {
    contrastText: white,
    dark: '#51D084',
    main: colors.green[600],
    light: colors.green[400],
  },
  info: {
    contrastText: white,
    dark: colors.blue[900],
    main: colors.blue[600],
    light: colors.blue[400],
  },
  warning: {
    contrastText: white,
    dark: colors.orange[900],
    main: colors.orange[600],
    light: colors.orange[400],
  },
  error: {
    contrastText: white,
    dark: '#E56860',
    main: colors.red[600],
    light: colors.red[400],
  },
  text: {
    primary: '#ffffff',
    secondary: '#A1A1B5',
    link: '#D5D5E2',
    blue: blue,
    lightBlue: lightBlue,
  },
  background: {
    default: '#F4F6F8',
    gray: '#000000',
    paper: black,
  },
  icon: '#A1A1B5',
  divider: colors.grey[200],
  neutral: '#F3F3FB',
};
