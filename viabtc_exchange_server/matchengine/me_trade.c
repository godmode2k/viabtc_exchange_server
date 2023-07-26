/*
 * Description: 
 *     History: yang@haipo.me, 2017/03/29, create
 */

# include "me_config.h"
# include "me_trade.h"

static dict_t *dict_market;

static uint32_t market_dict_hash_function(const void *key)
{
    return dict_generic_hash_function(key, strlen(key));
}

static int market_dict_key_compare(const void *key1, const void *key2)
{
    return strcmp(key1, key2);
}

static void *market_dict_key_dup(const void *key)
{
    return strdup(key);
}

static void market_dict_key_free(void *key)
{
    free(key);
}

int init_trade(void)
{
    dict_types type;
    memset(&type, 0, sizeof(type));
    type.hash_function = market_dict_hash_function;
    type.key_compare = market_dict_key_compare;
    type.key_dup = market_dict_key_dup;
    type.key_destructor = market_dict_key_free;

    dict_market = dict_create(&type, 64);
    if (dict_market == NULL)
        return -__LINE__;

    for (size_t i = 0; i < settings.market_num; ++i) {
        market_t *m = market_create(&settings.markets[i]);
        if (m == NULL) {
            return -__LINE__;
        }

        dict_add(dict_market, settings.markets[i].name, m);
    }

    return 0;
}

//! ADD NEW: [
// listing
int load_markets_listing(json_t *root, const char *key) {
	json_t *node = json_object_get(root, key);
	if (!node || !json_is_array(node)) {
		return -__LINE__;
	}

	//! ADD: data from DB
	//


	//! FIXME: realloc()
	size_t market_num = json_array_size(node);
	if ( settings.markets) { free (settings.markets); settings.markets = NULL; }
	settings.markets = malloc(sizeof(struct market) * market_num);
	settings.market_num = market_num;


	int count = 0;
	char* name = malloc(sizeof(char) * 24);
	if ( !name ) { return -__LINE__; }
	for (size_t i = 0; i < market_num; ++i) {
		json_t *row = json_array_get(node, i);
		if (!json_is_object(row))
			return -__LINE__;

		struct market _market;

		if ( !name ) { return -__LINE__; }
		memset( name, 0x00, sizeof(char) * 24 );

		ERR_RET_LN(read_cfg_str(row, "name", &name, NULL));
		//printf( "%s: %d: name = %s\n", __func__, i, name );
		_market.name = name;

		ERR_RET_LN(read_cfg_int(row, "fee_prec", &_market.fee_prec, false, 4));
		ERR_RET_LN(read_cfg_mpd(row, "min_amount", &_market.min_amount, "0.01"));

		json_t *stock = json_object_get(row, "stock");
		if (!stock || !json_is_object(stock)) return -__LINE__;
		ERR_RET_LN(read_cfg_str(stock, "name", &_market.stock, NULL));
		ERR_RET_LN(read_cfg_int(stock, "prec", &_market.stock_prec, true, 0));

		json_t *money = json_object_get(row, "money");
		if (!money || !json_is_object(money)) return -__LINE__;
		ERR_RET_LN(read_cfg_str(money, "name", &_market.money, NULL));
		ERR_RET_LN(read_cfg_int(money, "prec", &_market.money_prec, true, 0));


		//if (dict_find(dict_market, _market.name) == NULL) {
		//	continue; // found exist key (name)
		//}
		//if (dict_add(dict_market, _market.name, &_market) == NULL ) {
		//	continue; // found exist key (name)
		//}

		// re-set all
		if ( dict_add(dict_market, _market.name, &_market) ) {
			++count;
			printf( "added market: %s\n", _market.name );
		}

		ERR_RET_LN(read_cfg_str(row, "name", &settings.markets[i].name, NULL));
		ERR_RET_LN(read_cfg_int(row, "fee_prec", &settings.markets[i].fee_prec, false, 4));
		ERR_RET_LN(read_cfg_mpd(row, "min_amount", &settings.markets[i].min_amount, "0.01"));

		ERR_RET_LN(read_cfg_str(stock, "name", &settings.markets[i].stock, NULL));
		ERR_RET_LN(read_cfg_int(stock, "prec", &settings.markets[i].stock_prec, true, 0));

		ERR_RET_LN(read_cfg_str(money, "name", &settings.markets[i].money, NULL));
		ERR_RET_LN(read_cfg_int(money, "prec", &settings.markets[i].money_prec, true, 0));

		/*
		printf("[%d]: name = %s\n", i, markets[i].name);
		printf("[%d]: fee_prec = %d\n", i, markets[i].fee_prec);
		printf("[%d]: min_amount = %s\n", i, markets[i].min_amount);
		printf("[%d]: name = %s\n", i, markets[i].stock);
		printf("[%d]: prec = %d\n", i, markets[i].stock_prec);
		printf("[%d]: name = %s\n", i, markets[i].money);
		printf("[%d]: prec = %d\n", i, markets[i].money_prec);
		*/
	} // for ()

	if ( name ) {
		free( name );
		name = NULL;
	}

	return count;
}
// ]

market_t *get_market(const char *name)
{
    dict_entry *entry = dict_find(dict_market, name);
    if (entry)
        return entry->val;
    return NULL;
}

