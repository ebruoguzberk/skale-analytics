import React from 'react';
import { useHistory } from 'react-router-dom';
import { makeStyles } from '@material-ui/styles';
import SearchIcon from '@material-ui/icons/Search';
import { useCubeQuery } from '@cubejs-client/react';
import FormControl from '@material-ui/core/FormControl';
import palette from '../theme/palette';
import Autocomplete from '@material-ui/lab/Autocomplete';
import TextField from '@material-ui/core/TextField';
import InputAdornment from '@material-ui/core/InputAdornment';

const useStyles = makeStyles((theme) => ({
  root: {
    marginBottom: 32,
    width: '100%',
    color: palette.text.secondary,
    textClasses: {},
  },
  text: {
    color: palette.text.secondary,
    fontSize: 16,
  },
  icon: {
    color: palette.text.secondary,
  },
}));

const DelegatorSearch = (props) => {
  const history = useHistory();
  const classes = useStyles();

  const { resultSet, error, isLoading } = useCubeQuery({
    measures: ['Rewards.count'],
    timeDimensions: [
    ],
    order: {
      'Rewards.address': 'asc',
    },
    dimensions: ['Rewards.address','Rewards.type','Rewards.val_id','Rewards.escrow_address'],
    filters: [],
  });

  const handleChange = (value) => {
    if(value.type==="VALIDATOR")
    {
      history.push(`/validator/${value.val_id}`);
    }
    else
    {
      history.push(`/tokenholder/${value.address}`);
    }

  };

  if (isLoading) {
    return null;
  }

  if (error) {
    return <pre>{error.toString()}</pre>;
  }

  if (!resultSet) {
    return null;
  }

  const options = resultSet.tablePivot().map((item) => {
    if(item['Rewards.escrow_address']!=null)
    {
      return {
        id: item['Rewards.address'],
        address: item['Rewards.address'],
        val_id : item['Rewards.val_id'],
        escrow_address : item['Rewards.escrow_address'],
        type : item['Rewards.type'],
        text: `${item['Rewards.address']}-${item['Rewards.type']}-${item['Rewards.escrow_address']}`
      };
    }
    return {
      id: item['Rewards.address'],
      address: item['Rewards.address'],
      val_id : item['Rewards.val_id'],
      escrow_address : item['Rewards.escrow_address'],
      type : item['Rewards.type'],
      text: `${item['Rewards.address']}-${item['Rewards.type']}`
    };
  });

  return (
    <FormControl className={classes.root}>
      <Autocomplete
        disableClearable
        onChange={(event, value) => {
          handleChange(value);
        }}
        forcePopupIcon={false}
        options={options}
        getOptionLabel={(option) => option.text}
        renderInput={(params) => (
          <TextField
            {...params}
            label="Search"
            fullWidth
            InputProps={{
              ...params.InputProps,
              endAdornment: (
                <InputAdornment position="end">
                  <SearchIcon className={classes.icon} />
                </InputAdornment>
              ),
            }}
            InputLabelProps={{ classes: { root: classes.text } }}
          />
        )}
      />
    </FormControl>
  );
};

export default DelegatorSearch;
