cube(`NetworkInflation`, {
    sql: `SELECT inflation bounty_per_year,left(start_dt_int,4) b_year,inflation_percent, 
case when CURRENT_TIMESTAMP() between skale_token_inflation.start_dt_datetime 
and skale_token_inflation.end_dt_datetime then true else false end isitcurrent
            FROM mainnet.skale_token_inflation`,

    joins: {

    },

    measures: {
        bounty_per_year: {
            sql: `bounty_per_year`,
            type: `max`
        },
    },
    dimensions: {
        year:{
            sql: `b_year`,
            type: `string`,
            primaryKey: true,
            shown: true
        },
        inflation_percent: {
            sql: `bounty_per_year`,
            type: `string`
        }
        ,
        isitcurrent: {
            sql: `isitcurrent`,
            type: `boolean`
        }
    },
    refreshKey: {
        every: `1 minute`
    }
});
