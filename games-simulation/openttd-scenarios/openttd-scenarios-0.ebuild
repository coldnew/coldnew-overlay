# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit games

DESCRIPTION="Additional OpenTTD scenarios from ttdscenarios.com"
HOMEPAGE="http://ttdscenarios.com/"
SRC_URI="
	http://ttdscenarios.com/alp/zips/macca_3_islands.zip
	http://ttdscenarios.com/alp/zips/macca_alp_ranges.zip
	http://ttdscenarios.com/alp/zips/macca_goldrush.zip
	http://ttdscenarios.com/alp/zips/macca_levee.zip
	http://ttdscenarios.com/alp/zips/macca_longhaul.zip
	http://ttdscenarios.com/alp/zips/macca_norweg_fjord.zip
	http://ttdscenarios.com/alp/zips/macca_paper_million.zip
	http://ttdscenarios.com/alp/zips/macca_ringworld.zip
	http://ttdscenarios.com/alp/zips/macca_starland.zip
	http://ttdscenarios.com/alp/zips/macca_timber_ctry.zip

	http://ttdscenarios.com/trop/zips/macca_african_riv.zip
	http://ttdscenarios.com/trop/zips/macca_al_sharif.zip
	http://ttdscenarios.com/trop/zips/macca_ben_gara.zip
	http://ttdscenarios.com/trop/zips/macca_desert_isl.zip
	http://ttdscenarios.com/trop/zips/macca_desert_water.zip
	http://ttdscenarios.com/trop/zips/macca_long_islands.zip
	http://ttdscenarios.com/trop/zips/macca_pt_solomon.zip
	http://ttdscenarios.com/trop/zips/macca_quadrangle.zip
	http://ttdscenarios.com/trop/zips/macca_salinas.zip
	http://ttdscenarios.com/trop/zips/macca_suez_canal.zip
	http://ttdscenarios.com/trop/zips/macca_survival.zip
	http://ttdscenarios.com/trop/zips/macca_trop_isl.zip

	http://ttdscenarios.com/temp/zips/klynch_sg_plinburg.zip
	http://ttdscenarios.com/temp/zips/macca_4islands.zip
	http://ttdscenarios.com/temp/zips/macca_anthracite_isl.zip
	http://ttdscenarios.com/temp/zips/macca_barrier_island.zip
	http://ttdscenarios.com/temp/zips/macca_circ_cities.zip
	http://ttdscenarios.com/temp/zips/macca_islands.zip
	http://ttdscenarios.com/temp/zips/macca_oceania.zip
	http://ttdscenarios.com/temp/zips/macca_plinburg.zip
	http://ttdscenarios.com/temp/zips/macca_pt_william.zip
	http://ttdscenarios.com/temp/zips/macca_seaworld.zip
	http://ttdscenarios.com/temp/zips/macca_steel_ridges.zip
	http://ttdscenarios.com/temp/zips/macca_tribute_to_panic.zip
	http://ttdscenarios.com/temp/zips/macca_vol_islands.zip

	http://ttdscenarios.com/map/zips/coral_sg_scotland.zip
	http://ttdscenarios.com/map/zips/jeffa_nw_tasmania.zip
	http://ttdscenarios.com/map/zips/macca_caribbean_sea.zip
	http://ttdscenarios.com/map/zips/macca_scotland.zip
	http://ttdscenarios.com/map/zips/macca_victoria_aust.zip

	http://ttdscenarios.com/cont_panic/zips/macca_sg_liant.zip
	http://ttdscenarios.com/cont_panic/zips/panic_big_river.zip
	http://ttdscenarios.com/cont_panic/zips/panic_big_smoke.zip
	http://ttdscenarios.com/cont_panic/zips/panic_blue_lagoon.zip
	http://ttdscenarios.com/cont_panic/zips/panic_bwbw.zip
	http://ttdscenarios.com/cont_panic/zips/panic_cold.zip
	http://ttdscenarios.com/cont_panic/zips/panic_delta.zip
	http://ttdscenarios.com/cont_panic/zips/panic_downontheborder.zip
	http://ttdscenarios.com/cont_panic/zips/panic_golden_coast.zip
	http://ttdscenarios.com/cont_panic/zips/panic_iraqganistan.zip
	http://ttdscenarios.com/cont_panic/zips/panic_liant.zip
	http://ttdscenarios.com/cont_panic/zips/panic_new_india_mts.zip
	http://ttdscenarios.com/cont_panic/zips/panic_sanrafael.zip
	http://ttdscenarios.com/cont_panic/zips/panic_sg_madass_hinsane.zip
	http://ttdscenarios.com/cont_panic/zips/panic_suburbia.zip
	http://ttdscenarios.com/cont_panic/zips/panic_the_islands.zip
	http://ttdscenarios.com/cont_panic/zips/panic_thecage.zip
	http://ttdscenarios.com/cont_panic/zips/panic_tod.zip
	http://ttdscenarios.com/cont_panic/zips/panic_tropical_heat.zip
	http://ttdscenarios.com/cont_panic/zips/panic_wayoutwest.zip
	http://ttdscenarios.com/cont_panic/zips/panic_welshvalleys.zip

	http://ttdscenarios.com/cont_misc/zips/bob_eldorado.zip
	http://ttdscenarios.com/cont_misc/zips/bob_farmland.zip
	http://ttdscenarios.com/cont_misc/zips/bob_miningworld.zip
	http://ttdscenarios.com/cont_misc/zips/bob_star_island.zip
	http://ttdscenarios.com/cont_misc/zips/klynch_isthmus.zip
	http://ttdscenarios.com/cont_misc/zips/klynch_snow_world.zip
	http://ttdscenarios.com/cont_misc/zips/pvallecillo_num43.zip
	http://ttdscenarios.com/cont_misc/zips/s_begg_mountain_madness.zip
	http://ttdscenarios.com/cont_misc/zips/s_begg_vol_arch.zip
	http://ttdscenarios.com/cont_misc/zips/s_jade_pen_india.zip
"

RESTRICT="mirror"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-arch/unzip"
RDEPEND="games-simulation/openttd"

S="${WORKDIR}"

src_install() {
	local COUNT=0 FILE

	insinto "${GAMES_DATADIR}"/openttd/scenario/ttdscenarios.com

	find . -iname "*.sv0" | while read FILE
	do
		(( COUNT++ ))
		newins "${FILE}" "$( printf %08d ${COUNT} ).sv0"
	done

	prepgamesdirs
}
