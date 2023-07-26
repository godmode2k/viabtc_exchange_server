/*
 * Description: 
 *     History: yang@haipo.me, 2017/03/29, create
 */

# ifndef _ME_TRADE_H_
# define _ME_TRADE_H_

# include "me_market.h"

int init_trade(void);
market_t *get_market(const char *name);

//! ADD NEW: [
// listing
int load_markets_listing(json_t *root, const char *key);
// ]

# endif

