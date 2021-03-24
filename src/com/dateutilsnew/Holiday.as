/**
 * Copyright (c) 2008 Gareth Arch
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

/**
 * This utility class provides easy access to US Federal holidays based upon year or month
 */
 
package com.dateutilsnew {

	public class Holiday {
		
		public static const NEW_YEARS_DAY:String	= "New Year's Day";
		public static const MLK_DAY:String			= "Martin Luther King Day";
		public static const WASHINGTON_DAY:String	= "Washington's Day";
		public static const MEMORIAL_DAY:String		= "Memorial Day";
		public static const INDEPENDENCE_DAY:String	= "Independence Day";
		public static const LABOR_DAY:String		= "Labor Day";
		public static const COLUMBUS_DAY:String		= "Columbus Day";
		public static const VETERANS_DAY:String		= "Veteran's Day";
		public static const THANKSGIVING_DAY:String	= "Thanksgiving Day";
		public static const CHRISTMAS_DAY:String	= "Christmas Day";
		
		private static var _arrHoliday:Array = [];
		public static function get arrHoliday():Array {
			if ( _arrHoliday.length == 0 ) {
				_arrHoliday.push( Holiday.NEW_YEARS_DAY);
				_arrHoliday.push( Holiday.MLK_DAY);
				_arrHoliday.push( Holiday.WASHINGTON_DAY);
				_arrHoliday.push( Holiday.MEMORIAL_DAY);
				_arrHoliday.push( Holiday.INDEPENDENCE_DAY);
				_arrHoliday.push( Holiday.LABOR_DAY);
				_arrHoliday.push( Holiday.COLUMBUS_DAY);
				_arrHoliday.push( Holiday.VETERANS_DAY);
				_arrHoliday.push( Holiday.THANKSGIVING_DAY);
				_arrHoliday.push( Holiday.CHRISTMAS_DAY );
			}
			return _arrHoliday;
		}
		
		public function Holiday() {
		}
		
		public static function getDate( year:Number, holiday:String ):Date {
			
			switch ( holiday ) {
				case Holiday.NEW_YEARS_DAY:
					return new Date( year, DateUtils.monthAsNumber( DateUtils.JANUARY ), 1 );
					break;
				case Holiday.MLK_DAY:
					return new Date( year, DateUtils.monthAsNumber( DateUtils.JANUARY ),
										DateUtils.dayOfWeekIterationOfMonth( 3, DateUtils.MONDAY, new Date( year, DateUtils.monthAsNumber( DateUtils.JANUARY ) ) ).date );
					break;
				case Holiday.WASHINGTON_DAY:
					return new Date( year, DateUtils.monthAsNumber( DateUtils.FEBRUARY ),
										DateUtils.dayOfWeekIterationOfMonth( 3, DateUtils.MONDAY, new Date( year, DateUtils.monthAsNumber( DateUtils.FEBRUARY ) ) ).date );
					break;
				case Holiday.MEMORIAL_DAY:
					return new Date( year, DateUtils.monthAsNumber( DateUtils.MAY ),
										DateUtils.dayOfWeekIterationOfMonth( DateUtils.LAST, DateUtils.MONDAY, new Date( year, DateUtils.monthAsNumber( DateUtils.MAY ) ) ).date );
					break;
				case Holiday.INDEPENDENCE_DAY:
					return new Date( year, DateUtils.monthAsNumber( DateUtils.JULY ), 4 );
					break;
				case Holiday.LABOR_DAY:
					return new Date( year, DateUtils.monthAsNumber( DateUtils.SEPTEMBER ),
										DateUtils.dayOfWeekIterationOfMonth( 1, DateUtils.MONDAY, new Date( year, DateUtils.monthAsNumber( DateUtils.SEPTEMBER ) ) ).date );
					break;
				case Holiday.COLUMBUS_DAY:
					return new Date( year, DateUtils.monthAsNumber( DateUtils.OCTOBER ),
										DateUtils.dayOfWeekIterationOfMonth( 2, DateUtils.MONDAY, new Date( year, DateUtils.monthAsNumber( DateUtils.OCTOBER ) ) ).date );
					break;
				case Holiday.VETERANS_DAY:
					return new Date( year, DateUtils.monthAsNumber( DateUtils.NOVEMBER ), 11 );
					break;
				case Holiday.THANKSGIVING_DAY:
					return new Date( year, DateUtils.monthAsNumber( DateUtils.NOVEMBER ),
										DateUtils.dayOfWeekIterationOfMonth( 4, DateUtils.THURSDAY, new Date( year, DateUtils.monthAsNumber( DateUtils.NOVEMBER ) ) ).date );
					break;
				case Holiday.CHRISTMAS_DAY:
					return new Date( year, DateUtils.monthAsNumber( DateUtils.DECEMBER ), 25 );
					break;
			}
			
			return null;
			
		}
		
		public static function holidayByMonth( month:Number ):Array {
			var _arrReturn:Array = [];
			
			arrHoliday.forEach( function( item:*, index:uint, array:Array ):void {
				if ( Holiday.getDate( ( new Date() ).fullYear, String( item ) ).month == month ) {
					_arrReturn.push( String( item ) );
				}
			} );
			
			return _arrReturn;
		}

	}
}




